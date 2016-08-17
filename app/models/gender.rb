class Gender < ActiveRecord::Base

  attr_accessible :is_deleted, :name
  has_many :users
end
