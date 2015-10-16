class AddUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :handle
      t.text :auth_token
      t.string :name
      t.text :user_id
    end
  end
end
