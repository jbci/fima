Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_APP_ID'], ENV['GOOGLE_APP_SECRET'],
    {
      :name => "google",
      :scope => "email, profile",
      :prompt => "select_account",
      :image_aspect_ratio => "square",
      :image_size => 50
    }
end

OmniAuth.config.full_host = Rails.env.production? ? ENV['BASE_URL'] : ENV['BASE_URL'] + " " + ENV['BASE_URL_PORT']
