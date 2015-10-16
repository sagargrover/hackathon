class ChangeTypeOfUserId < ActiveRecord::Migration
  def change
  	remove_column :seens, :user_id
  	add_column :seens, :user_id, :string
  end
end
