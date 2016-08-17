class AddFieldToGroupUsers < ActiveRecord::Migration
  def change
    add_column :group_users, :added_by, :integer, :null => false
  end
end
