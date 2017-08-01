class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_locale
  def set_locale
    I18n.locale = user_locale

    # after store current locale
    cookies[:locale] = params[:locale] if params[:locale]
  rescue I18n::InvalidLocale
    I18n.locale = I18n.default_locale
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:sign_in, keys: added_attrs)
  end

  private

    def user_locale
      params[:locale] || cookies[:locale] || http_head_locale || I18n.default_locale
    end

    def http_head_locale
      http_accept_language.language_region_compatible_from(I18n.available_locales)
    end

end
