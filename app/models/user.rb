class User < ApplicationRecord
  ############################################################################################
  ## PeterGate Roles                                                                        ##
  ## The :user role is added by default and shouldn't be included in this list.             ##
  ## The :root_admin can access any page regardless of access settings. Use with caution!   ##
  ## The multiple option can be set to true if you need users to have multiple roles.       ##
  petergate(roles: [:admin, :editor], multiple: false)                                      ##
  ############################################################################################ 
 

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  has_one :profile , dependent: :destroy
  has_one :preference , dependent: :destroy
  has_one :timeline,as: :timeable,dependent: :destroy
  has_many :notification_subject,class_name:'Notification',as: :notifiable
  has_many :enablers,as: :enable,foreign_key: :author_id,dependent: :destroy
  has_many :notifications,foreign_key: :recipient_id,dependent: :destroy
  has_many :sent_notifications,class_name:'Notification',foreign_key: :actor_id,dependent: :destroy
  has_many :invitations,foreign_key: :requester_id,dependent: :destroy
  has_many :owned_clubs,class_name:'Club',foreign_key: :owner,dependent: :destroy
  has_many :club_admins,foreign_key: :admin_id,dependent: :destroy
  has_many :administered_clubs,through: :club_admins,source: :club
  has_and_belongs_to_many :clubs
  has_many :chatroom_users
  has_many :chatrooms, through: :chatroom_users
  has_many :messages
  has_many :likes
  has_many :liked_enablers,through: :likes,source: :liked,source_type: 'Enabler'
  has_many :liked_comments,through: :likes,source: :liked,source_type: 'Comment'
  after_create :create_profile, :create_preference,:create_timeline
  #after_save :create_profile, :create_preference,:create_timeline
  has_friendship#TODO there is a problem with the block / unblock mechanism issue raised if it doesnot get handled we will forl the gem and make the change for ourselves

  attr_writer :login

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def create_profile
    unless self.profile.present?
      Profile.create(user:self)
    end
  end

  def create_timeline
    unless self.timeline.present?
      Timeline.create(timeable:self)
    end
  end

  def create_preference
    unless self.preference.present?
      Preference.create(user:self)
    end
  end

  def images
    self.profile.images
  end

  def profile_image
    all_images=self.profile.images
    latest_image=all_images.select{|x| x if x.latest}.last
    latest_image.location.url rescue ""
  end

  def display_name
    #TODO Optimize this.
    full_name = Profile.select(:first_name,:last_name).where(user:self).last.as_json.values.select{|x| x unless x.nil?}.join(" ")
    full_name = full_name.strip.empty? ? self.email.split('@').first : full_name
  end
  alias_method :name, :display_name

  def image_count
    self.profile.images.count
  end

  def is_admin_of
    self.administered_clubs
  end
  def notification_links(notification)
    message = "#{notification.actor.display_name} #{notification.action}"
    path = profile_path(self)
    return message,path
  end

  def subscribed_timeline
    result = self.friends.includes(:timeline).collect{|x| x.timeline.id} + self.clubs.includes(:timeline).collect{|x| x.timeline.id} + self.owned_clubs.includes(:timeline).collect{|x| x.timeline.id}
    result << self.timeline.id
  end

  # includes syntax
  #User.all.includes(:timeline,:preference,{profile: :images},{clubs: :users},{sent_notifications: :recipient})

end

#TODO an option to the owner to choose admins
#TODO admins to be able to moderate posts
#TODO of owner or admin make a post inactive then notification to the post owner
#TODO cover pic upload
#TODO Cover UI
#TODO Apply indentation to CKEDITOR List


