class AddFieldsToUserSettings < ActiveRecord::Migration
  def change
    add_column :user_settings, :last_name_with_public, :boolean, :default => true
    add_column :user_settings, :last_name_with_friends, :boolean, :default => true
    add_column :user_settings, :age_with_public, :boolean, :default => true
    add_column :user_settings, :height_with_friends, :boolean, :default => true
    add_column :user_settings, :body_type_with_friends, :boolean, :default => true
    remove_column :user_settings, :show_age
    remove_column :user_settings, :allow_chat_from_non_friend
    remove_column :user_settings, :allow_mail_from_non_friend
  end
end
