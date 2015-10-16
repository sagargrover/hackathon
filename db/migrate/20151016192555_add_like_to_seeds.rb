class AddLikeToSeeds < ActiveRecord::Migration
  def change
  	add_column :seeds, :yays, :integer, :default => 0
  	add_column :seeds, :nays, :integer, :default => 0

  	Seed.find_each do |seed|
      seed.yays = 0
      seed.nays = 0
  	end
  end
end
