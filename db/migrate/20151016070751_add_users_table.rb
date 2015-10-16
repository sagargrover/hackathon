class AddUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :handle
      t.string :password
    end
  end
end
