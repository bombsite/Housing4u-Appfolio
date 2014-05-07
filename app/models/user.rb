class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable


  has_many :Units

  validates_format_of :phone_number, :with => /\d{10}/, :allow_blank => true, :if => :phone_number_changed?

  serialize :bed_before_11pm_accepted
  serialize :wake_before_9am_accepted
  serialize :music_often_accepted
  serialize :visitors_often_accepted
  serialize :social_accepted

  def password_required?
    (!password.blank? && !password_confirmation.blank?) || new_record?
  end


  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(first_name:auth.info.first_name,
                           last_name:auth.info.last_name,
                           #provider:auth.provider,
                           #uid:auth.uid,
                           
                           email:auth.info.email,
                           fb_photo_url:auth.info.image,
                           password:Devise.friendly_token[0,20],
        )
      end    end
  end

end
