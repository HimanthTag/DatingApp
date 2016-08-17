class CreateGroupMessages < ActiveRecord::Migration
  def change
    create_table :group_messages do |t|
      t.integer :group_user_id, :null=>false
      t.string :message
      t.boolean :is_deleted, :default=>false

      t.timestamps
    end
  end
end
