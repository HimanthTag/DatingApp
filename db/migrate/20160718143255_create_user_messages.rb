class CreateUserMessages < ActiveRecord::Migration
  def change
    create_table :user_messages do |t|
      t.integer :user_id
      t.string :message
      t.boolean :is_deleted, :default => false

      t.timestamps
    end
  end
end
