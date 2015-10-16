class AddCoordinatesToSeeds < ActiveRecord::Migration
  def change
  	add_column :seeds, :coordinates, :spatial, limit: {:srid=>4326, :type=>"point"}
  end
end
