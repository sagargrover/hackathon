class CreateSeens < ActiveRecord::Migration
  def change
    create_table :seens do |t|
      t.integer :seed_id
      t.integer :user_id

      t.timestamps
    end
  end
end
