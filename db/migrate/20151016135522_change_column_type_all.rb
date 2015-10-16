class ChangeColumnTypeAll < ActiveRecord::Migration
  def change
  	remove_column :users, :user_id
  	add_column :users, :user_id, :string
  	remove_column :seeds, :creator_id
  	add_column :seeds, :creator_id, :string
  	remove_column :tags, :tagged_user_id
  	add_column :tags, :tagged_user_id, :string
  	remove_column :tags, :tagger_user_id
  	add_column :tags, :tagger_user_id, :string
  end
end
