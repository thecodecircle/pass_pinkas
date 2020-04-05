class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  around_action :switch_locale

  def switch_locale(&action)
    locale = current_user.try(:lang) || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def set_locale
    puts "****************************************"
    puts "locale: #{params[:locale]}"
    puts "****************************************"
    case params[:locale]
    when "he"
      current_user.update(lang: "he")
    when "en"
      current_user.update(lang: "en")
    when "ru"
      current_user.update(lang: "ru")
    end
    redirect_to root_path
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :role])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :name, :role])
    end
end
