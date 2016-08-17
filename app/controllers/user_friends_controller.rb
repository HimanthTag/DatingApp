class UserFriendsController < ApplicationController
  before_filter :set_user_friend, only: [:show, :edit, :update, :destroy, :accept_friend]

  respond_to :html

  def index
    @user_friends = UserFriend.accepted_friends(current_user.id,100)
    #@user_friends = UserFriend.all
    #respond_with(@user_friends)
  end

  def show
    respond_with(@user_friend)
  end

  def new
    @user_friend = UserFriend.new
    respond_with(@user_friend)
  end

  def edit
  end

  def create
    @user_friend = UserFriend.new(params[:user_friend])
    @user_friend.save
    respond_with(@user_friend)
  end

  def accept_friend
    # @user_friend.update_attribute("is_accepted",params[:acceptance_status])
    # if @user_friend.is_accepted
    #   @friend_record = UserFriend.find_or_create_by_user_id_and_friend_id(@user_friend.friend_id,@user_friend.user_id) #UserFriend.create(:user_id=>@user_friend.friend_id,:friend_id=>@user_friend.user_id,:is_accepted=>true)
    #   @friend_record.update_attribute("is_accepted",true)
    # end
    # @accepted_friends = UserFriend.accepted_friends(current_user.id)
    # respond_to do |format|      
    #     format.html { render :partial => "landing/my_friends", :layout => false}
    # end
    begin
      @user_friend.update_attribute("is_accepted",params[:acceptance_status])
      if @user_friend.is_accepted
        @friend_record = UserFriend.find_or_create_by_user_id_and_friend_id(@user_friend.friend_id,@user_friend.user_id) #UserFriend.create(:user_id=>@user_friend.friend_id,:friend_id=>@user_friend.user_id,:is_accepted=>true)
        @friend_record.update_attribute("is_accepted",true)
      end
      check_for_pending_requests
      render :json => {"status"=>true,"message"=>"Accepted successfully","pending_count"=>@friends_request.try(:length) || 0}
    rescue => error
      render :json => {"status" => "false", "message"=>"Internal server error has occured","status_code"=>500}
    end
  end

  def remove_sent_request
    begin
      UserFriend.find_by_id(params[:request_id]).update_attribute("is_deleted",true)
      render :json => {"status" => "true", "message" => "Removed friend request"}
    rescue => error
      p error
      render :json => {"status" => "false", "message"=>"Internal server error has occured","status_code"=>500}
    end
  end

  def remove_friend
    UserFriend.find_by_user_id_and_friend_id(current_user.id,params[:friend_id]).update_attribute("is_deleted",true)
    UserFriend.find_by_friend_id_and_user_id(current_user.id,params[:friend_id]).update_attribute("is_deleted",true)
    @is_friend = nil#Using this object in common template to identify if user is friend
    @profile_likes = ProfileLike.where(:user_id=>params[:friend_id]).length
    @user = User.find(params[:friend_id])
    respond_to do |format|  
      format.html { render :partial => "users/friend_request_status", :layout => false}
    end
  end


  def update
    @user_friend.update_attributes(params[:user_friend])
    respond_with(@user_friend)
  end

  def destroy
    @user_friend.destroy
    respond_with(@user_friend)
  end

  private
    def set_user_friend
      @user_friend = UserFriend.find(params[:id])
    end
end
