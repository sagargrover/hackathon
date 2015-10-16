class Seed < ActiveRecord::Base
  validates :name, :creator_id, :coordinates, :presence => true
end
