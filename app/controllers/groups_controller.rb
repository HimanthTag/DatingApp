class GroupsController < ApplicationController
  before_filter :set_group, only: [:show, :edit, :update, :destroy, :update_group_image, :add_member, :add_member_to_group]

  respond_to :html

  def index
    @groups = Group.where(:id=> (GroupMembership.where(:member_id=>current_user.id,:member_type=>"User",:is_deleted=>false).first.group_id))
     #current_user.groups.joins(:group_memberships).where("groups.group_memberships.is_deleted=false")
     # @groups = Group.with_member(current_user)
    respond_with(@groups)
  end

  def show
    @group_users = @group.users.includes(:user_friends)
    @group_messages = @group.group_messages.order("created_at DESC").includes(:comments)
    @group_friends = UserFriend.friends_id(current_user)
    respond_with(@group)
  end

  def new
    @group = Group.new
    respond_with(@group)
  end

  def edit
  end

  def create
    @group = Group.new(params[:group])
    @group.save
    respond_with(@group)
  end

  def update
    @group.update_attributes(params[:group])
    respond_with(@group)
  end

  def destroy
    @group.destroy
    respond_with(@group)
  end

  def add_member
    @user_friends = current_user.user_friends
    group_members = User.in_group(@group).pluck(:id)

    @my_friends = User.where(:id=>(@user_friends.pluck(:friend_id) - group_members))
    respond_with(@my_friends)
  end

  def add_member_to_group
    @user = User.find_by_id(params[:friend_id])
    @group.add @user

    @user_friends = current_user.user_friends
    group_members = User.in_group(@group).pluck(:id)
    @my_friends = User.where(:id=>(@user_friends.pluck(:friend_id) - group_members))
    respond_to do |format|
      format.html { render :partial => "friends_list", :locals=>{:my_friends=>@my_friends, :group=>@group}, :layout => false}
    end
    # redirect_to add_member_group_path(@group)
  end

  def update_group_image
    respond_to do |format|
      if @group.update_attributes!(params[:group])
        format.html { redirect_to group_path(@group), notice: 'Group Image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to group_path(@group), notice: 'Group Image was not successfully updated.' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
    # respond_with(@group)
  end

  private
    def set_group
      @group = Group.find(params[:id])
    end
end
