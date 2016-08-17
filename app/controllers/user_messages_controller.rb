class UserMessagesController < ApplicationController
  before_filter :set_user_message, only: [:show, :edit, :update, :destroy]
  before_filter :check_friends, only: [:index, :new_user_msg, :message_conversation]

  respond_to :html

  def index
    if check_friends
      @user_messages = UserMessage.where('(user_id =? and receiver_id =?) OR (user_id =? and receiver_id =?)',current_user.id,params[:uid],params[:uid],current_user.id)
      respond_with(@user_messages)
    else
      @user_messages = []
      @receiver = []
      flash[:alert] = "Click your friends to start conversation"
      respond_with(@user_messages)
    end
  end

  def show
    respond_with(@user_message)
  end

  def new
    @user_message = UserMessage.new    
    respond_with(@user_message)
  end

  def edit
  end

  def create
    @user_message = UserMessage.new(params[:user_message])
    @user_message.save
    respond_with(@user_message)
  end

  def update
    @user_message.update_attributes(params[:user_message])
    respond_with(@user_message)
  end

  def destroy
    @user_message.destroy
    @receiver = User.find_by_id(params[:uid])
    @user_messages = UserMessage.where('(user_id =? and receiver_id =?) OR (user_id =? and receiver_id =?)',current_user.id,params[:uid].to_i,params[:uid].to_i,current_user.id)
    respond_to do |format|
      format.html { render :partial => "user_messages/messages", :locals=>{:user_messages => @user_messages}, :layout => false}
    end
  end

  def message_conversation
    if check_friends
      if MessageConversation.between(current_user.id,params[:uid]).present?
        @conversation = MessageConversation.between(current_user.id,params[:uid]).first
      else
        @conversation = MessageConversation.create!({:sender_id => current_user.id, :recipient_id => params[:uid]})
      end
      @user_messages = UserMessage.where('(user_id =? and receiver_id =?) OR (user_id =? and receiver_id =?)',current_user.id,params[:uid],params[:uid],current_user.id)
      respond_with(@user_messages)
    else
      @user_messages = []
      @receiver = []
      flash[:alert] = "Click your friends to start conversation"
      respond_with(@user_messages)
    end
  end

  def new_user_msg
    if check_friends
      if MessageConversation.between(current_user.id,params[:user_message][:receiver_id]).present?
        @conversation = MessageConversation.between(current_user.id,params[:user_message][:receiver_id]).first
      else
        @conversation = MessageConversation.create!({:sender_id => current_user.id, :recipient_id => params[:user_message][:receiver_id]})
      end
      @user_message = UserMessage.new(params[:user_message])
      @user_message.save
      @receiver = User.find_by_id(params[:user_message][:receiver_id])
      @user_messages = UserMessage.where('(user_id =? and receiver_id =?) OR (user_id =? and receiver_id =?)',current_user.id,params[:user_message][:receiver_id].to_i,params[:user_message][:receiver_id].to_i,current_user.id)
      respond_to do |format|
        format.html { render :partial => "user_messages/messages", :locals=>{:user_messages => @user_messages, :from_partial=>true, :user_message => @user_message}, :layout => false}
      end
    else
      #Code for flash  message to user
      #flash[:alert] = "Sending message to unauthorized user"
      render :text => "Sending message to unauthorized user"
    end
  end

  private
    def set_user_message
      @user_message = UserMessage.find(params[:id])
    end

    def check_friends
      @user_friends = UserFriend.accepted_friends(current_user.id)
      @receiver = User.find_by_id(params[:uid])
      @user_friends.pluck(:user_id).include?(@receiver.try(:id)) ? true : false
    end
end
