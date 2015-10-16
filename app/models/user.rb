class User < ActiveRecord::Base
  def self.create user_id, fb_auth_token, name
    if User.find_by_user_id(user_id).nil?
      user = User.new
      user.user_id = user_id
      user.auth_token = fb_auth_token
      user.name = name
      trimmed_name = name.gsub(/\s+/, "")
      index = get_uniq_handle trimmed_name
      user.handle = trimmed_name + index.to_s
      user.save!
      return 1
    else
	    return 0
	  end
  end

  def myplants
    Seed.where(creator_id:self.user_id)
  end

  def myseeds
    Seed.joins("inner join tags on seed_id=seeds.id").where(creator_id:self.user_id).select("seeds.*")
  end

  def saw seed_id
    seen = Seen.new
    seen.seed_id = seed_id
    seen.user_id = user_id
    seen.save!
  end

  private

  def self.get_uniq_handle name
    names = User.where("name like '#{name}%'").pluck(:name)
    if names.length == 0
      return 0
    else
      numeral = names.last.slice! name
      return numeral.to_i + 1
    end
  end

  def seen
    Seed.joins("inner join seens on seeds.seed_id=seens.seeds_id").where("seens.user_id=#{user_id}").select("seeds.*")
  end

  def seencount
    seen.count
  end
end
