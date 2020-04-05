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
    puts "family_id: #{params[:family_id]}" if params[:family_id].present?
    puts "house_id: #{params[:house_id]}" if params[:house_id].present?
    puts "locale: #{params[:locale]}" if params[:locale].present?
    current_user.update(locale: params[:locale]) if params[:locale].present?

    if !params[:family_id].present? && !params[:house_id].present?
      f = Family.create(name: params[:family], score: 0)
      h = House.create(name: params[:house], score: 0, family_id: f.id)
      current_user.houses << h
    elsif params[:family_id].present?
      h = House.create(name: params[:house], score: 0, family_id: params[:family_id])
      current_user.houses << h
    elsif params[:house_id].present?
      current_user.houses << House.find(params[:house_id])
    end
    puts "Done!"
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
