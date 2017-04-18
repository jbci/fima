class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_language

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :store_current_location, :unless => :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:names, :surnames, :area_of_residence_id,
                                                       :area_of_interest_id, :provider, :uid])
  end

  def set_language
    if session[:locale].nil?
      if params[:locale].nil?
        session[:locale] = I18n.default_locale
      else
        session[:locale] = params[:locale]
      end
    else
      if params[:locale].nil?
        session[:locale] = I18n.default_locale
      else
        session[:locale] = params[:locale]
      end
    end
    I18n.locale =  I18n.available_locales.map{|l|l.to_s}.include?(session[:locale]) ? session[:locale] : I18n.default_locale
  end

  def store_current_location
    store_location_for(:user, request.url)
  end

  def after_sign_out_path_for(resource)
    request.referrer || root_path
  end

end
