class CreateProfileLikes < ActiveRecord::Migration
  def change
    create_table :profile_likes do |t|
      t.integer :user_id
      t.integer :liker_id
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
