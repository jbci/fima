OmniAuth.config.full_host = Rails.env.production? ? 'https://' + ENV['BASE_URL'] : ENV['BASE_URL'] + ":" + ENV['BASE_URL_PORT']
