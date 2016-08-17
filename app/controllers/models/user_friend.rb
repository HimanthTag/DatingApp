class UserFriend < ActiveRecord::Base
  attr_accessible :friend_id, :is_accepted, :is_deleted, :request_message, :user_id

  belongs_to :user
  belongs_to :friend, :class_name => "User", :foreign_key => "friend_id"
  default_scope { where(is_deleted: false) }

  def self.friends_and_requests(current_user_id)
  	accepted_friends = UserFriend.accepted_friends(current_user_id)
    received_requests = UserFriend.received_requests(current_user_id)
    return accepted_friends,received_requests
  end

  def self.received_requests(current_user_id)
    where(:friend_id=>current_user_id,:is_accepted=>nil).includes(:friend,:user=>[:user_profile_picture,:attachments])
  end

  def self.accepted_friends(current_user_id,default_limit=8)
	 return where("friend_id=? and is_accepted=1",current_user_id).limit(default_limit).order("updated_at desc").includes(:friend=>:user_profile_picture,:user=>[:user_friends,:user_profile_picture,:attachments])
  end

  def self.total_friends_count(user_id)
    return where("friend_id=? and is_accepted=1",user_id).pluck(:id).length
  end

  def self.friends_id(user_id)
    return where("friend_id=? and is_accepted=1",user_id).pluck(:user_id)
  end

  def self.sent_requests(user_id)
    return where("user_id=? and is_accepted is null",user_id).limit(12).includes(:friend=>:user_profile_picture)
  end
end
