class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
	before_action :store_action
  before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :no_service_worker
  before_action :authenticate_user!

  around_action :switch_locale

  def switch_locale(&action)
    if %w(sessions registrations).include?(controller_name)
      locale = params[:locale] || I18n.default_locale
    else
      locale = current_user.try(:locale) || I18n.default_locale
    end
    I18n.with_locale(locale, &action)
  end

  def set_locale
    puts "****************************************"
    puts "locale: #{params[:locale]}"
    puts "****************************************"
    case params[:locale]
    when "he"
      current_user.update(locale: "he")
    when "en"
      current_user.update(locale: "en")
    when "ru"
      current_user.update(locale: "ru")
    end
    redirect_to root_path
  end

  def no_service_worker
    redirect_to root_path if action_name == "service_worker"
  end

	def store_action
	    return unless request.get?
	    # if (request.path != "/users/sign_up" &&
	        # !request.xhr?) # don't store ajax calls
	      store_location_for(:user, request.fullpath)

	    # end
  end


  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :role])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :name, :role])
    end
end
