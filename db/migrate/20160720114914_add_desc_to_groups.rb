class AddDescToGroups < ActiveRecord::Migration
  def change
  	add_column :groups, :description, :string
  	rename_column :groups, :type, :name
  end
end
