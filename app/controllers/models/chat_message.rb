class ChatMessage < ActiveRecord::Base
  belongs_to :chat_conversation
  belongs_to :user
  attr_accessible :body

  validates_presence_of :body, :chat_conversation_id, :user_id
end
