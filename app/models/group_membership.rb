class GroupMembership < ActiveRecord::Base
  groupify :group_membership
  attr_accessible :is_deleted  
end
