class CreateChatMessages < ActiveRecord::Migration
  def change
    create_table :chat_messages do |t|
      t.text :body
      t.references :chat_conversation
      t.references :user

      t.timestamps
    end
    add_index :chat_messages, :chat_conversation_id
    add_index :chat_messages, :user_id
  end
end
