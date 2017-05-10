class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  ratyrate_rater

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.names = auth.info.name
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
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
        user.names = data["name"] if user.names.blank?
        user.provider = session["devise.facebook_data"]["provider"]
        user.uid = session["devise.facebook_data"]["uid"]

      elsif data = session["devise.google_data"] && session["devise.google_data"]["info"]
        user.email = data["email"] if user.email.blank?
        user.names = data["name"] if user.names.blank?
        user.provider = session["devise.google_data"]["provider"]
        user.uid = session["devise.google_data"]["uid"]

      end
    end
  end

  def self.to_csv
    attributes = %w{id email names surnames area_of_residence_id area_of_interest_id provider sign_in_count created_at  last_sign_in_at}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end

end
