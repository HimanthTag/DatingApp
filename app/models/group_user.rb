class GroupUser < ActiveRecord::Base
  attr_accessible :group_id, :is_active, :is_admin, :is_deleted, :user_id, :added_by
end
