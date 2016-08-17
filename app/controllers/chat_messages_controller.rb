class ChatMessagesController < ApplicationController
    before_filter :authenticate_user!

    def create
        @conversation = ChatConversation.find(params[:chat_conversation_id])
        @message = @conversation.chat_messages.build(params[:chat_message])
        @message.user_id = current_user.id
        @message.save!

        @path = chat_conversation_path(@conversation)
    end

    private

    def message_params
    params.require(:message).permit(:body)
    end
end
