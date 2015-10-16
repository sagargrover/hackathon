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
end
