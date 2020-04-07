# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
	# before_create :store_user_location!, if: :storable_location?

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    # super

		build_resource(sign_up_params)

		resource.save
		yield resource if block_given?
		if resource.persisted?
				  if resource.active_for_authentication?
				    set_flash_message! :notice, :signed_up
				    sign_up(resource_name, resource)
				    respond_with resource, location: after_sign_up_path_for(resource)
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
				  else
				    set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
				    expire_data_after_sign_in!
				    respond_with resource, location: after_inactive_sign_up_path_for(resource)
				  end
		else

			set_flash_message! :not_saved, :not_saved
			if User.pluck(:username).include?(resource.username)
				set_flash_message! :username, :username
			end
			if resource.password != resource.password_confirmation
				set_flash_message! :password, :password
			elsif resource.password.length < 6
				set_flash_message! :too_short, :too_short
			end
		  clean_up_passwords resource
		  set_minimum_password_length
			redirect_to stored_location_for(resource)
		  # response_to_sign_up_failure resource
		end
		# if @user.save
		# 	puts "****************************************"
		# 	puts "username: #{@user.username}"
		# 	puts "family_id: #{params[:family_id]}" if params[:family_id].present?
		# 	puts "house_id: #{params[:house_id]}" if params[:house_id].present?
		# 	puts "locale: #{params[:locale]}" if params[:locale].present?
		# 	current_user.update(locale: params[:locale]) if params[:locale].present?
		#
		# 	if !params[:family_id].present? && !params[:house_id].present?
		# 		f = Family.create(name: params[:family], score: 0)
		# 		h = House.create(name: params[:house], score: 0, family_id: f.id)
		# 		current_user.houses << h
		# 	elsif params[:family_id].present?
		# 		h = House.create(name: params[:house], score: 0, family_id: params[:family_id])
		# 		current_user.houses << h
		# 	elsif params[:house_id].present?
		# 		current_user.houses << House.find(params[:house_id])
		# 	end
		# 	puts "Done!"
		# end
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

  protected

	def response_to_sign_up_failure(resource)
    stored_location_for(resource)
		# root_path, alert:"fail"
	end

	# Its important that the location is NOT stored if:
	 # - The request method is not GET (non idempotent)
	 # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an
	 #    infinite redirect loop.
	 # - The request is an Ajax request as this can lead to very unexpected behaviour.
		 def storable_location?
			 request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
		 end

		 def store_user_location!
			 # :user is the scope we are authenticating
			 store_location_for(:user, request.fullpath)
			 puts "****************************************"
			 puts request.fullpath
		 end

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
	# 	if @user.save
	# 		super(resource)
	# 	else
	# 		redirect_to "google.com"
	# 	end
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
