class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  acts_as_messageable

  devise :database_authenticatable, :confirmable, :registerable,:recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :twitter]

  handle_asynchronously :send_reset_password_instructions
  handle_asynchronously :send_confirmation_instructions
  handle_asynchronously :send_on_create_confirmation_instructions

  validates :first_name,  :presence => true, allow_blank: false
  validates :last_name,  :presence => true, allow_blank: false
  validates :email,  :presence => true,:uniqueness => true, allow_blank: false
  # validates :dob,  :presence => true, allow_blank: true
  # validates :gender,  :presence => true, allow_blank: true
  # validates :city,  :presence => true, allow_blank: true
  # validates :state_id,  :presence => true, allow_blank: true
  # validates :zip_code,  :presence => true, allow_blank: true

  groupify :group_member
  groupify :named_group_member

  # Setup accessible (or protected) attributes for your model

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :first_name, :last_name,
         :age, :contact_number, :dob, :gender_id, :relationship_id, :city, :state_id,
         :country, :about_me, :is_active, :is_deleted, :is_online, :provider, :uid,:fb_image, 
         :attachments, :attachments_attributes, :ethnicity_id, :middle_name, :zip_code, :pokemongo_team_id,
         :favorite_pokemon, :hobbies, :relationship_interest_id, :height_feet, :height_inch, :body_type, :am_over_18

  has_many :user_friends, :dependent => :destroy
  has_many :friends, :class_name => "UserFriend", :foreign_key => 'friend_id'
  has_many :group_users, :dependent => :destroy
  # has_many :group_messages, :through => :group_users, :dependent => :destroy
  has_one :user_profile_picture, :dependent => :destroy
  has_one :user_setting, :dependent => :destroy
  belongs_to :group, :foreign_key => "pokemongo_team_id"
  belongs_to :state
  belongs_to :gender
  belongs_to :relationship_status  

  has_many :attachments, :as => :attachable, :dependent => :destroy
  belongs_to :relationship
  belongs_to :relationship_interest


  accepts_nested_attributes_for :attachments, allow_destroy: true #, reject_if: proc { |attributes| attributes[:attachment].nil? }
  accepts_nested_attributes_for :gender, allow_destroy: true
  accepts_nested_attributes_for :relationship, allow_destroy: true

  has_many :chat_conversations, :foreign_key => :sender_id, :dependent => :destroy
  has_many :profile_likes, :dependent => :destroy

  default_scope { includes(:attachments, :user_profile_picture, :user_setting, :relationship_interest, :group) }

  include ActiveModel::Dirty
  after_update :assign_user_to_team
  after_create :create_default_settings

  # attr_accessible :title, :body

  def full_name(is_friend=true) 
    if user_setting.last_name_with_friends && is_friend
      "#{first_name} #{last_name}"
    elsif user_setting.last_name_with_public && !is_friend
      "#{first_name} #{last_name}"
    else
      first_name
    end
  end

  def team_name
    #Group.find_by_id(pokemongo_team_id).try(:name) || "No Team Joined Yet"
    try(:group).try(:name) || "No Team Joined Yet"
  end

  def team_icon
    unless pokemongo_team_id.nil?
      "/assets/team#{pokemongo_team_id}.png"
    else
      return nil
    end
  end

  def relationship_interest_icon
    unless relationship_interest_id.nil?
      "/assets/relation#{relationship_interest_id}.png"
    else
      return nil
    end
  end

  def self.attachment_path(attachment_url)
    if Rails.env == "development"
      "http://osdevelopment.techaffinity.com/social-dating/" << attachment_url.to_s
    else
      attachment_url.to_s
    end
  end

  def image_path
    if user_profile_picture.try(:attachment).nil?
      if gender_id==2
        "/assets/women.jpeg" 
      else
        "/assets/men.jpg"
      end
    else
      if Rails.env == "development"
        "http://osdevelopment.techaffinity.com/social-dating/"  << user_profile_picture.try(:attachment).try(:attachment).to_s
        # "http://localhost:3000/"  << user_profile_picture.try(:attachment).try(:attachment).to_s
      else
        "http://osdevelopment.techaffinity.com/social-dating/"  << user_profile_picture.try(:attachment).try(:attachment).to_s
      end
    end
  end

  def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    user.email = auth.info.email
	    user.password = Devise.friendly_token[0,20]
	    user.first_name = auth.info.first_name   # assuming the user model has a first name
	    user.last_name = auth.info.last_name   # assuming the user model has a last name
	    user.fb_image = auth.info.image # assuming the user model has an image
      user.skip_confirmation!
	  end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
	  user = User.where(:provider => auth.provider, :uid => auth.uid).first
	  if user
	    return user
	  else
	    registered_user = User.where(:email => auth.uid + "@twitter.com").first
	    if registered_user
	      return registered_user
	    else
	      user = User.create(first_name:auth.info.name,
	        provider:auth.provider,
	        uid:auth.uid,
	        email:auth.uid+"@twitter.com",
	        password:Devise.friendly_token[0,20],
	        fb_image: auth.info.image
	      )
	    end
	  end
  end

  def mailboxer_name
    self.name
  end

  def mailboxer_email(object)
    self.email
  end
  #user age calculation by dob
  def self.age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def self.create_group_members
    User.where("pokemongo_team_id is not null").each do |usr|
      Group.find(usr.pokemongo_team_id).add usr
      # GroupMembership.create(:member_id=>usr.id,:group_id=>usr.pokemongo_team_id,:added_by=>usr.id,:group_type=>"Group",:member_type=>"User")      
    end
  end

  def self.create_setting_for_old_users
    all.each do |usr|
      UserSetting.find_or_create_by_user_id(usr.id)  
    end
  end

  def self.update_user_defaults
    all.each do |usr|
      if usr.pokemongo_team_id.nil?
        usr.pokemongo_team_id = rand(1..3)
      end
      if usr.relationship_interest_id.nil?
        usr.relationship_interest_id = rand(1..3)
      end
      usr.save
    end
  end

  #Send Devise email with queuing process using delayed job active record gem
  #Send confirmation email after creating new user
  def send_on_create_confirmation_instructions
    Devise::Mailer.delay.confirmation_instructions(self, self.confirmation_token, opts={})
  end

  def send_reset_password_instructions
        token = set_reset_password_token
        send_reset_password_instructions_notification(token)
        token
      end
  def set_reset_password_token
    raw, enc = Devise.token_generator.generate(self.class, :reset_password_token)

    self.reset_password_token   = enc
    self.reset_password_sent_at = Time.now.utc
    save(validate: false)
    raw
  end
  #Send reset password email
  def send_reset_password_instructions_notification(token)
    Devise::Mailer.delay.reset_password_instructions(self, token, opts={})
  end
  
  #send unlock email
  def send_unlock_instructions
    Devise::Mailer.delay.unlock_instructions(self, :unlock_instructions, opts={})
  end

  private
  def create_default_settings
    UserSetting.create(:user_id=>id)
  end

  def assign_user_to_team
    if pokemongo_team_id_changed?       
      unless pokemongo_team_id_was.nil? 
        previous_group = GroupMembership.find_by_member_id_and_group_id(id,pokemongo_team_id_was)
        unless previous_group.nil?
          previous_group.update_attributes(:is_deleted=>is_deleted)
        end
      end
      current_group = GroupMembership.find_by_member_id_and_group_id(id,pokemongo_team_id)
      if current_group.nil?      
        Group.find(pokemongo_team_id).add self      
      else
        current_group.update_attributes(:is_deleted=>false)
      end
    end
  end 

end
