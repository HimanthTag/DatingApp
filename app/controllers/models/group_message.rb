class GroupMessage < ActiveRecord::Base
  attr_accessible :group_user_id, :is_deleted, :message, :group_id
  acts_as_commentable

  has_many :comments, :as => :commentable
  belongs_to :group
  belongs_to :user, :foreign_key=>"group_user_id", :class_name=> 'User'
end
