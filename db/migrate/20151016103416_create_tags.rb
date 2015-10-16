class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
    	t.integer :tagged_user_id
      t.integer :tagger_user_id
      t.integer :seed_id
    end
  end
end
