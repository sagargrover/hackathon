module NearbyHelper

  REGIONS_URL = "http://harmans.housing.com:3001/"
  LISTENING_RADIUS = 300

  def nearby_seeds user_id,my_loc,bounds_ne,bounds_sw,labels=[]
    bounds_ne  =  "ST_GeomFromText('%s')" % [bounds_ne]
    bounds_sw  =  "ST_GeomFromText('%s')" % [bounds_sw]
    my_loc  =  "ST_SetSRID(ST_GeomFromText('%s'),4326)" % [my_loc]

    viewport = "ST_SetSRID(ST_MakeBox2D(%s,%s),4326)" % [bounds_ne,bounds_sw]
    if bounds_ne.include? 'POINT(0.0 0.0)'
      viewport = "ST_Buffer(%s,0.00659256611421917)" % [my_loc]
    end
    range_condition = "ST_Intersects(coordinates,%s)" % [viewport]
    
    range_seeds = Seed.where(range_condition)

    # logic is for union of labels, not intersection
    label_list = labels.map {|l| "'"+l+"'" }.join(",").to_s
    label_condition = "id in (select distinct seed_id from labels where label in (%s))" % [label_list]

    labelled_seeds = labels.empty? ? range_seeds : range_seeds.where(label_condition)
    
    tagged_condition = "id in (select seed_id from tags where tagged_user_id = '%s')" % [user_id]
    visible_condition = "is_public or %s" % [tagged_condition]
    
    result_seeds = labelled_seeds.where(visible_condition)

    distance = "ST_Distance(ST_Transform(coordinates,3785),ST_Transform(%s,3785))" % [my_loc]

    selection_with_nearby = "id,title,url,is_public as public,creator_id,
                ST_Y(coordinates) as lat,
                ST_X(coordinates) as lng,
                yays as likes, nays as dislikes,
                %s < #{LISTENING_RADIUS} as nearby,
                %s as distance" % [distance, distance]
  
    result_seeds_with_nearby = result_seeds.select(selection_with_nearby)

    return format_nearby_seeds(result_seeds_with_nearby,user_id),200
  end

  def address_builder lat, lng
    url = "#{REGIONS_URL}api/v1/polygon/reverse_geocode?lat=%s&lng=%s" % [lat,lng]
    puts url
    rev_geocode = Net::HTTP.get_response URI(url)
    rev_geocode = JSON.parse(rev_geocode.body)
    addr=[]
    ['sublocality','locality','housing_region','city','state'].each do |entity|
    addr<<rev_geocode[entity]['name'] if rev_geocode.keys.include? entity
    end
    return addr.join(', ')
  end

  def format_nearby_seeds result_seeds_with_nearby, user_id
    result = []
    result_seeds_with_nearby.each do |raw_seed|
      seed=Hash.new
      puts raw_seed.attributes
      seed.merge!(raw_seed.attributes.slice('id','lat','lng','title','url','likes','dislikes',
                                            'is_public','nearby','distance'))
      
      lat = raw_seed.lat
      lng = raw_seed.lng
      
      seed['address'] = address_builder(lat,lng)
      # Remove this when FrontEnd realizes it's better to leave creator_handle in there
      seed['taglist'] = raw_seed.taghandles-[raw_seed.creator_handle]
      seed['labels'] = raw_seed.labels
      seed['posted_by'] = raw_seed.creator_handle
      seed['seen'] = raw_seed.viewers.exists?(:user_id=>user_id)

      result << seed
    end
    result
  end
end
