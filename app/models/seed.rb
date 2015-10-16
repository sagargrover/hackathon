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
    Users.joins("inner join seens on users.user_id=seens.user_id").where("seen.seed_id=#{id}").select("users.*")
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
end
