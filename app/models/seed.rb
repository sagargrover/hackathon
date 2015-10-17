class Seed < ActiveRecord::Base
  def taglist
    Tag.where(seed_id:self.id).pluck(:tagged_user_id)
  end

  def taghandles
    Tag.joins("inner join users on tagged_user_id=user_id").where(seed_id:self.id).pluck(:handle)
  end

  def labels
    Label.where(seed_id:id).pluck(:label)
  end

  def self.labelled label
    joins("inner join labels on seed_id=seeds.id").where("labels.label='#{label}'").select("seeds.*")
  end

  def creator_handle
    User.find_by(user_id:creator_id).handle
  end

  def viewers
    User.joins("inner join seens on users.user_id=seens.user_id").where("seens.seed_id=#{id}").select("users.*")
  end

  def viewcount
    viewers.count
  end

  def yay
    increment!(:yays)
  end

  def nay
    increment!(:nays)
  end

  def add_label label
    newlabel = Label.new
    newlabel.seed_id = id
    newlabel.label = label
    newlabel.save!
  end

  def self.yay
    self.find_each do |seed|
      seed.increment!(:yays)
    end
  end

  def self.nay
    self.find_each do |seed|
      increment!(:nays)
    end
  end

  def self.register user_id, fb_auth_id, link, tag_ids, lat, lng, title, seed_type, labels=[]

    user_id='881955835223475' if user_id.nil?
    fb_auth_id='CAACoRvM54ZC8BAFR6DZCjUnI9haIdiK9y5w7TJKd9w49gRd4McVpFlTsg7csP9enaNZCgPeu4DbSdCzQ6ZAjyOE7t0g5amPVjiSpOXxtVFxTBJr2RTrPbLta6sVxu5c4Q9NP2uveAcx8Wo5WHKUkAZC2j55p9iP9Uj8lIkMp5IHsa3J1QZCvTrkmwZBTooJOSqaBI5oEDZCxmhBDg1Pc5grqef9M1GaNMs5XRyVIZAuEZABgZDZD' if user_id=='881955835223475'
    lat=72 if lat.nil?
    lng=19 if lng.nil?

    user = User.find_by_user_id(user_id)
    #binding.pry
    a = 1
    if a == 1
      seed = Seed.new
      seed.title = title
      seed.is_public = seed_type
      seed.url = link
      seed.creator_id = user_id
      #binding.pry
      seed.save!
      query =  "UPDATE seeds SET coordinates  = ST_GeomFromText('POINT(#{lng} #{lat})', 4326) where id = #{seed.id}"
      Seed.connection.execute(query)
      tag = Tag.new
      tag.seed_id = seed.id
      tag.tagged_user_id = user_id
      tag.tagger_user_id = user_id
      tag.save!
      if !(tag_ids.nil?)
        tag_ids.each do |tag_id|
          tag = Tag.new
          tag.seed_id = seed.id
          tag.tagged_user_id = tag_id
          tag.tagger_user_id = user_id
          tag.save!
        end
      end
      labels.each do |l|
        seed.add_label l
      end
    end
    return link, 1
  end
end
