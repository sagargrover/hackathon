class AddSeedsTable < ActiveRecord::Migration
  def change
  	create_table :seeds do |t|
  	  t.string :title
  	  t.boolean :public
  	  t.string :url
  	  t.integer :creator_id
  	  t.timestamps
  	end
  end
end
