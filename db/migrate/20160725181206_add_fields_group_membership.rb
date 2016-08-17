class AddFieldsGroupMembership < ActiveRecord::Migration
  def up
  	add_column :group_memberships, :is_deleted, :boolean, :default => false
  end

  def down
  	remove_column :group_memberships, :is_deleted
  end
end
