class ProfileLike < ActiveRecord::Base
  attr_accessible :is_deleted, :liker_id, :user_id
  belongs_to :user
end
