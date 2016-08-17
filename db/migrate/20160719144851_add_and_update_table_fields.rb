class AddAndUpdateTableFields < ActiveRecord::Migration
  def up
  	add_column :users, :is_online, :boolean
  	rename_column :genders, :type, :name
    rename_column :relationships, :status, :name
  	rename_column :users, :country_id, :country
  	change_column :users, :country, :string
    rename_column :users, :relationship_status_id, :relationship_id
  end

  def down
  	remove_column :users, :is_online
  	rename_column :genders, :name, :type
    rename_column :relationships, :name, :status
  	rename_column :users, :country, :country_id
  	change_column :users, :country_id, :integer
    rename_column :users, :relationship_id, :relationship_status_id
  end
end
