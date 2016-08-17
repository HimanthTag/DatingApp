class CreateUserProfilePictures < ActiveRecord::Migration
  def change
    create_table :user_profile_pictures do |t|
      t.references :user
      t.references :attachment

      t.timestamps
    end
  end
end
