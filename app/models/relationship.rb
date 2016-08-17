class Relationship < ActiveRecord::Base
  attr_accessible :description, :is_deleted, :name
  has_many :users
end
