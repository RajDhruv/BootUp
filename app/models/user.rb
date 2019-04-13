class User < ApplicationRecord
  ############################################################################################
  ## PeterGate Roles                                                                        ##
  ## The :user role is added by default and shouldn't be included in this list.             ##
  ## The :root_admin can access any page regardless of access settings. Use with caution!   ##
  ## The multiple option can be set to true if you need users to have multiple roles.       ##
  petergate(roles: [:admin, :editor], multiple: true)                                      ##
  ############################################################################################ 
 

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :profile , dependent: :destroy
  has_one :preference , dependent: :destroy
  has_and_belongs_to_many :clubs
  after_create :create_profile, :create_preference
  after_save :create_profile, :create_preference
  has_friendship

  def create_profile
    unless self.profile.present?
      Profile.create(user:self)
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
    user_profile=self.profile
    first_name = user_profile.first_name rescue ""
    last_name = user_profile.last_name rescue ""
    full_name = "#{first_name} #{last_name}"
    full_name = full_name.strip.empty? ? self.email.split('@').first : full_name
  end

  def image_count
    self.profile.images.count
  end

  def is_admin_of
    ClubAdmin.where(admin_id: self.id).includes(:club).map(&:club)
  end
  #TODO make a preference model that will store the persistence
end
