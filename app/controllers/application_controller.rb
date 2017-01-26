class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_language

  def set_language
    if session[:locale].nil?
      if params[:locale].nil?
        session[:locale] = I18n.default_locale
      else
        session[:locale] = params[:locale]
      end
    else
      if params[:locale].nil?

      else
        session[:locale] = params[:locale]
      end
    end
    I18n.locale =  I18n.available_locales.map{|l|l.to_s}.include?(session[:locale]) ? session[:locale] : I18n.default_locale
  end
end
