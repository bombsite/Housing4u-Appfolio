class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable


  has_many :Units

  validates_format_of :phone_number, :with => /\d{10}/, :allow_blank => true, :if => :phone_number_changed?

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
        user = User.create(#name:auth.extra.raw_info.name,
                           #provider:auth.provider,
                           #uid:auth.uid,
                           email:auth.info.email,
                           password:Devise.friendly_token[0,20],
        )
      end    end
  end

end
