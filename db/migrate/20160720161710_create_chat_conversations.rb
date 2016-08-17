class CreateChatConversations < ActiveRecord::Migration
  def change
    create_table :chat_conversations do |t|
      t.integer :sender_id
      t.integer :recipient_id

      t.timestamps
    end

    add_index :chat_conversations, :sender_id
    add_index :chat_conversations, :recipient_id
  end
end