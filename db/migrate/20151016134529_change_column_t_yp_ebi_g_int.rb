class ChangeColumnTYpEbiGInt < ActiveRecord::Migration
  def change
  	remove_column :users, :user_id
  	add_column :users, :user_id, :bigint
  end
end
