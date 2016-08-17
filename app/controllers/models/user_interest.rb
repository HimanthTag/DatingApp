class UserInterest < ActiveRecord::Base
  attr_accessible :interest_id, :is_deleted, :user_id
end
