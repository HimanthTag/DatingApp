class ChatConversationsController < ApplicationController
    before_filter :authenticate_user!
    skip_before_filter :verify_authenticity_token

    layout false

    def create
        if ChatConversation.between(params[:sender_id],params[:recipient_id]).present?
          @conversation = ChatConversation.between(params[:sender_id],params[:recipient_id]).first
        else
          @conversation = ChatConversation.create!({:sender_id => params[:sender_id], :recipient_id => params[:recipient_id]})
        end

        render json: { conversation_id: @conversation.id }
    end

    def show
        @conversation = ChatConversation.find(params[:id])
        @reciever = interlocutor(@conversation)
        @messages = @conversation.chat_messages
        @message = ChatMessage.new
    end

    private
    def conversation_params
        params.permit(:sender_id, :recipient_id)
    end

    def interlocutor(conversation)
        current_user == conversation.recipient ? conversation.sender : conversation.recipient
    end

end
