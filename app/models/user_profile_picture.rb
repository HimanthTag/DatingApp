class UserProfilePicture < ActiveRecord::Base
  attr_accessible :attachment_id, :user_id
  belongs_to :user
  belongs_to :attachment
end
