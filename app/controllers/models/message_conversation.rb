class MessageConversation < ActiveRecord::Base
    attr_accessible :recipient_id, :sender_id
    belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
    belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'

    scope :between, ->(sender_id,recipient_id) do
        where("(message_conversations.sender_id = ? AND message_conversations.recipient_id =?) OR (message_conversations.sender_id = ? AND message_conversations.recipient_id =?)", sender_id,recipient_id, recipient_id, sender_id)
    end
end
