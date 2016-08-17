class UserSetting < ActiveRecord::Base
  attr_accessible :user_id, :last_name_with_public, :last_name_with_friends,
  				  :age_with_public, :height_with_friends, :body_type_with_friends

  belongs_to :user
end
