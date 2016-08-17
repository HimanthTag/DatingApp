class UserMessage < ActiveRecord::Base
  attr_accessible :is_deleted, :message, :user_id, :receiver_id
  belongs_to :user
  belongs_to :receiver, :class_name => "User", :foreign_key => "receiver_id"

end
