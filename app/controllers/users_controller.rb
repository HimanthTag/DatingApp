require 'carmen'
include Carmen
class UsersController < ApplicationController
  # GET /users
  # GET /users.json


  def pending_friends
    user_friends_id = []
    user_friends_id << UserFriend.where(:friend_id=>current_user.id,:is_deleted=>0).pluck(:user_id)
    user_friends_id << UserFriend.where(:user_id=>current_user.id,:is_deleted=>0).pluck(:friend_id)
    user_friends_id << current_user.id    
    if params.has_key?(:q)
      get_age_group_params(params[:q][:age_cont])
    end
    @q = User.ransack(params[:q])
    if params.has_key?(:q)            
      retain_age_group_params(params[:q])   
      users = @q.result.includes(:groups, :relationship, :gender, :user_friends,:user_profile_picture)      
      @users = users.where("id not in (?)",user_friends_id.flatten).limit(9).offset(params[:offset] || 0)
      if params.has_key?(:offset)
        respond_to do |format|      
          format.html { render :partial => "new_friends", :layout => false}        
        end
      end
    else
      @users = []
      # @users = User.where("id not in (?)",user_friends_id.flatten).includes(:user_profile_picture,:user_friends)
    end    
  end

  #To get search group params from age group cont
  def get_age_group_params(search_params)
     case search_params
     when "1"
      params[:q][:age_gteq] = 18
     when "2"
      params[:q][:age_gteq] = 18
      params[:q][:age_lteq] = 20
     when "3"
      params[:q][:age_gteq] = 21
      params[:q][:age_lteq] = 25
     when "4"
      params[:q][:age_gteq] = 26
      params[:q][:age_lteq] = 30
     when "5"
      params[:q][:age_gteq] = 31
      params[:q][:age_lteq] = 35
     when "6"
      params[:q][:age_gteq] = 36
      params[:q][:age_lteq] = 40
     when "7"
      params[:q][:age_gteq] = 41
     else
      params[:q][:age_cont] = ""
     end
     params[:q][:age_cont] = ""
  end

  #To reatin the age_cont and display it in view template
  def retain_age_group_params(search_params)
    if search_params[:age_gteq] && search_params[:age_lteq]
      if search_params[:age_gteq] == 18 && search_params[:age_lteq] == 20
        params[:q][:age_cont] = "2"
      elsif search_params[:age_gteq] == 21 && search_params[:age_lteq] == 25
        params[:q][:age_cont] = "3"
      elsif search_params[:age_gteq] == 26 && search_params[:age_lteq] == 30
        params[:q][:age_cont] = "4"
      elsif search_params[:age_gteq] == 31 && search_params[:age_lteq] == 35
        params[:q][:age_cont] = "5"
      else
        params[:q][:age_cont] = "6"
      end
    elsif search_params[:age_gteq]
      params[:q][:age_cont] = search_params[:age_gteq] == 18 ? "1" : "7"      
    end
  end

  def index
    pending_friends
    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @users }
    end
  end

  def check_email_availability
    begin         
      @user = User.unscoped.find_by_email(params[:email_id])
      render :json => {"status" => @user.nil?, "message" =>  @user.nil? ? "Can be registered" : "Email already registered"}
    rescue
      render :json => {"status" => false, "message" => "Internal server error"}
    end
  end

  def add_friend
    request_sent = UserFriend.where("user_id=? and friend_id=?",current_user.id,params[:friend_id])
    request_received = UserFriend.where("friend_id=? and user_id=?",current_user.id,params[:friend_id])
    
    if request_sent.empty? and request_received.empty?
      @is_friend = UserFriend.create(:user_id=>current_user.id,:friend_id=>params[:friend_id])
    end
    if params.has_key? (:list_page)
      # pending_friends
      # @request_sent = false
      # partial_page = "friends_list"
      render :json => {"status"=>true,"message"=>"Request sent successfully"}
    else
      @profile_likes = ProfileLike.where(:user_id=>params[:friend_id]).length
      @user = User.find_by_id(params[:friend_id])
      partial_page = "friend_request_status"
      respond_to do |format|      
        format.html { render :partial => partial_page, :layout => false}        
      end 
    end   
  end

  def check_if_friend
    request_sent = UserFriend.where("user_id=? and friend_id=?",current_user.id,params[:id]).try(:first)
    request_received = UserFriend.where("friend_id=? and user_id=?",current_user.id,params[:id]).try(:first)
    @is_friend = nil
    unless request_sent.nil?
      @is_friend = request_sent#.is_accepted? ? request_sent : nil
    end
    unless request_received.nil?
      @is_friend = request_received#.is_accepted? ? request_received : nil
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @user_friends = UserFriend.accepted_friends(@user.id)
    @my_friends_id = UserFriend.friends_id(current_user.id)
    check_if_friend    
    @profile_likes = ProfileLike.where(:user_id=>params[:id]).length
    if @user.id==current_user.id
      @sent_requests = UserFriend.sent_requests(current_user.id)    
    else
      @sent_requests = []
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def accept_new_friend    
    @user_friend = UserFriend.find(params[:id])
    @user_friend.update_attribute("is_accepted",params[:acceptance_status])
    if @user_friend.is_accepted
      UserFriend.create(:user_id=>@user_friend.friend_id,:friend_id=>@user_friend.user_id,:is_accepted=>true)
    end    
    @is_friend = params[:acceptance_status].to_s=="1" ? @user_friend : nil
    @profile_likes = ProfileLike.where(:user_id=>@user_friend.friend_id).length
    @user = current_user
    respond_to do |format|  
      format.html { render :partial => "friend_request_status", :layout => false}
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    @attachment = @user.attachments.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    if params[:id].to_i==current_user.id
      @user = User.find(params[:id])
    else
      redirect_to root_path, notice: "You are trying to access unauthorized page"
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        # params[:attachments][:user].each do |attachment|
        #   @attachment = @user.attachments.create!(:attachment => attachment)
        # end
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update    
    @user = current_user
    if params[:user][:dob].present?
      params[:user][:dob], params[:user][:age] = age(params[:user][:dob])
    end
    
    # This block is to remove mandatory update for password field in edit user page.
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
    end    
    respond_to do |format|
      begin
        if @user.update_attributes!(params[:user])
            params[:attachments][:user].each do |attachment|
            begin
              @attachment = @user.attachments.create!(:attachment => attachment)            
            rescue => error
              p error.message
              message = error.message.include?("You are not allowed") ? "Invalid file format" : "You can upload max up to 3 profile pics only"
              format.html { redirect_to edit_user_path(@user), alert: message }
              format.json { head :no_content }
            end
          end if params[:attachments].present? && params[:attachments][:user].present?
          if @user.sign_in_count==1
            format.html { redirect_to users_list_path, notice: "Let's find your pokes" }
          else
            if check_if_email_updated
              Notify.send_email_change_notification(current_user).deliver!
              #Delayed job for send email change notification email but not working as expected
              #Notify.delay.send_email_change_notification(current_user)
              # format.html { redirect_to edit_user_path(@user), notice: 'User successfully updated.You have to confirm your new email address before continuing.' }
              format.html { redirect_to root_path, notice: 'User successfully updated.You have to confirm your new email address before continuing.' }
            else
              # format.html { redirect_to edit_user_path(@user), notice: 'User successfully updated.' }
              format.html { redirect_to root_path, notice: 'User successfully updated.' }
            end
            format.json { head :no_content }
          end
        else
          format.html { render action: "edit" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
        user_pp = UserProfilePicture.find_by_user_id(@user.try(:id))
        @user.create_user_profile_picture(:attachment_id=>@attachment.try(:id)) unless user_pp.present?
       rescue ActiveRecord::RecordInvalid => invalid
          puts invalid.record.errors.messages
          format.html { render action: "edit" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def check_if_email_updated
    current_user.email != params[:user][:email] ? true : false
  end

  def make_profile_picture
    @user = User.find(params[:id])
    @attachment = Attachment.find_by_id(params[:attachment_id])
    make_pp(@user,@attachment)
    respond_to do |format|
      format.html { redirect_to edit_user_path(@user), notice: 'User was successfully updated.' }
      format.json { head :no_content }
    end
  end

  def delete_image
    @user = User.find(params[:id])
    @attachment = Attachment.find_by_id(params[:attachment_id])
    @attachment.destroy
    respond_to do |format|
      format.html { redirect_to edit_user_path(@user), notice: 'Image was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def settings
    @user_setting = current_user.user_setting
  end

  def update_settings
    @user_setting = current_user.user_setting
    @user_setting.update_attributes(params[:user_setting])
    respond_to do |format|
      format.html { redirect_to settings_path, notice: 'Settings was successfully updated.' }
      format.json { render :json=> {"message"=>"Settings updated successfully"} }
    end
    # render :json=> {"status"=>true, "message"=>"Settings updated successfully"}
  end

  private
  def make_pp(user,attachment)
    user_pp = UserProfilePicture.find_or_create_by_user_id(user.try(:id))
    user_pp.update_attributes(:attachment_id=>attachment.try(:id))
  end
end
