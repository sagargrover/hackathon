class Seed < ActiveRecord::Base
  def taglist
    Tag.where(seed_id:self.id).pluck(:tagged_user_id)
  end

  def taghandles
    Tag.joins("inner join users on tagged_user_id=user_id").where(seed_id:self.id).pluck(:handle)
  end

  def creator_handle
    User.find_by(user_id:creator_id).handle
  end

  def viewers
    User.joins("inner join seens on users.user_id=seens.user_id").where("seen.seed_id=#{id}").select("users.*")
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

  def self.register user_id, fb_auth_id, tag_ids, lat, lng, title, seed_type
    link = SecureRandom.hex(10)
    user = User.find_by_user_id(user_id)
    if user.auth_token != fb_auth_id
      return "Wrong authentication", 0
    end
    if (user.nil?)
      return "User not found", 0
    else
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
    end
    return link, 1
  end
end
