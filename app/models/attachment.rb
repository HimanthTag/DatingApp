class Attachment < ActiveRecord::Base
  attr_accessible :attachment
  has_one :user_profile_picture, :dependent => :destroy
  belongs_to :attachable, :polymorphic => true
  mount_uploader :attachment, AttachmentUploader

# Validations when uploading only 3 images in edit profile photo
LIMIT = 3

validate do |record|
  record.validate_photo_quota
end

def validate_photo_quota
  return unless self.attachable
  if self.attachable.attachments(:reload).count >= LIMIT
    errors.add(:base, :exceeded_quota)
  end
end

end
