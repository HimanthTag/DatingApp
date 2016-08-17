class CreateUserFriends < ActiveRecord::Migration
  def change
    create_table :user_friends do |t|
      t.integer :user_id
      t.integer :friend_id
      t.boolean :is_accepted
      t.string :request_message
      t.boolean :is_deleted, :default => false

      t.timestamps
    end
  end
end
