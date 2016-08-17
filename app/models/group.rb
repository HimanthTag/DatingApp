class Group < ActiveRecord::Base
  groupify :group, members: [:users], default_members: :users

  attr_accessible :name, :description, :attachment, :attachment_attributes

  has_one :attachment, :as => :attachable
  has_many :group_messages, :dependent => :destroy

  accepts_nested_attributes_for :attachment, allow_destroy: true

  def image_path
    if attachment.nil?
      "/assets/default_image.png"
    else
      "http://osdevelopment.techaffinity.com/social-dating/"  << attachment.attachment.to_s
    end
  end
  
end
