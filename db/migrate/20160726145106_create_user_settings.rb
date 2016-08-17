class CreateUserSettings < ActiveRecord::Migration
  def change
    create_table :user_settings do |t|
      t.integer :user_id
      t.boolean :show_age, :default => true
      t.boolean :allow_chat_from_non_friend, :default => true
      t.boolean :allow_mail_from_non_friend, :default => true

      t.timestamps
    end
  end
end
