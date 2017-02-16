class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

   def self.from_omniauth(auth)
     p "def self.from_omniauth(auth)"
     p auth
     where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
       user.email = auth.info.email
       user.password = Devise.friendly_token[0,20]
       user.provider = auth.provider
       user.uid = auth.uid
      #  user.name = auth.info.name   # assuming the user model has a name
      #  user.image = auth.info.image # assuming the user model has an image
       # If you are using confirmable and the provider(s) you use validate emails,
       # uncomment the line below to skip the confirmation emails.
       # user.skip_confirmation!
     end
   end

   def self.new_with_session(params, session)
     p " def self.new_with_session(params, session)  def self.new_with_session(params, session)"
     p session["devise.facebook_data"]
     p session["devise.facebook_data"]["provider"]
     p session["devise.facebook_data"]["uid"]
     p " raw_data end"
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        p " def self.new_with_session(params, session)  def self.new_with_session(params, session)"
        p data
        user.email = data["email"] if user.email.blank?
        user.names = data["name"] if user.names.blank?
        user.provider = session["devise.facebook_data"]["provider"]
        user.uid = session["devise.facebook_data"]["uid"]
      end
    end
  end

end
