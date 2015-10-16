class ChangePublicColumnToIsPublic < ActiveRecord::Migration
  def change
  	rename_column :seeds, :public, :is_public
  end
end
