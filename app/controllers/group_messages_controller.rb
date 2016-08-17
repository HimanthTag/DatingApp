class GroupMessagesController < ApplicationController
  before_filter :set_group_message, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @group_messages = GroupMessage.all
    respond_with(@group_messages)
  end

  def show
    respond_with(@group_message)
  end

  def new
    @group_message = GroupMessage.new
    @group = Group.find(params[:group_id])
    respond_with(@group_message)
  end

  def edit
  end

  def create
    @group_message = GroupMessage.new(params[:group_message])
    @group_message.save
    respond_with(@group_message)
  end

  def new_group_msg
    @group = Group.find_by_id(params[:group_id])
    @group_message = @group.group_messages.build
    @group_message.update_attributes(:message=>params[:message],:group_user_id=>current_user.id)
    @group_message.save

    @group_messages = @group.group_messages.order("created_at DESC").includes(:comments)

    respond_to do |format|
      format.html { render :partial => "group_messages/all_group_posts", :locals=>{:group_messages=>@group_messages, :group => @group}, :layout => false}
    end 
  end

  def new_group_msg_cmt
    @group = Group.find_by_id(params[:group_id])
    group_message = GroupMessage.find_by_id(params[:group_message_id])
    comment = Comment.build_from( group_message, current_user.id, params[:comment])
    comment.save!
    respond_to do |format|
      format.html { render :partial => "group_messages/all_group_post_cmts", :locals=>{:group => @group, :group_message => group_message}, :layout => false}
    end 
  end

  def update
    @group_message.update_attributes(params[:group_message])
    respond_with(@group_message)
  end

  def destroy
    @group = @group_message.group
    @group_message.destroy
    respond_with(@group)
  end

  private
    def set_group_message
      @group_message = GroupMessage.find(params[:id])
    end
end
