class CreateGroupUsers < ActiveRecord::Migration
  def change
    create_table :group_users do |t|
      t.integer :group_id, :null => false
      t.integer :user_id, :null => false
      t.boolean :is_admin, :default => 0
      t.boolean :is_deleted, :default => 0
      t.boolean :is_active, :default => 1

      t.timestamps
    end
  end
end
