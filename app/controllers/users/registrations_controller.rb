# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super
    puts "****************************************"
    puts "username: #{@user.username}"
    puts "type: #{params[:type]}"
    puts "houseable_id: #{params[:houseable_id]}"
    puts "houseable_name: #{params[:houseable_name]}" if params[:houseable_id] == "w8"

    # if no params, completely new
    f = Family.create(name: params[:family], score: 0)
    h = House.create(name: params[:houseable_name], score: 0, family_id: params[:houseable_id])
    current_user.houses << h

    roles = {
       kid: "jbhl",
       house: "ecumv",
       family: "ei",
       region: "tzur",
       movement: "bugv"
      }
    if params[:new] == "y"
      case roles.key(params[:type])
      when :family
      when :house
      end
    else
      if roles.key(params[:type]) == :kid
        MyHouse.create(user_id: @user.id, role: "kid", my_houseable_id: params[:houseable_id], my_houseable_type: "House")
      else
        MyHouse.create(user_id: @user.id, role: "guide", my_houseable_id: params[:houseable_id], my_houseable_type: roles.key(params[:type]).to_s.capitalize())
      end
    end

    puts "Created MyHouse!"
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
