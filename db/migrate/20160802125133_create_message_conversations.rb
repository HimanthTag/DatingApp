class CreateMessageConversations < ActiveRecord::Migration
  def change
    create_table :message_conversations do |t|
      t.integer :sender_id
      t.integer :recipient_id

      t.timestamps
    end
  end
end
