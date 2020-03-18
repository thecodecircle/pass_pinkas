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
    puts "groupable_id: #{params[:groupable_id]}"
    puts "groupable_name: #{params[:groupable_name]}" if params[:groupable_id] == "w8"
    @user.score = 0
    @user.save 
    roles = {
       kid: "jbhl",
       group: "ecumv",
       branch: "ei",
       region: "tzur",
       movement: "bugv"
      }

    if params[:new] == "y"
      case roles.key(params[:type])
      when :movement
        m = Movement.create(name: params[:groupable_name])
        MyGroup.create(user_id: @user.id, role: "guide", my_groupable_id: m.id, my_groupable_type: "Movement")
      when :region
        r = Region.create(name: params[:groupable_name], score: 0, movement_id: params[:groupable_id])
        MyGroup.create(user_id: @user.id, role: "guide", my_groupable_id: r.id, my_groupable_type: "Region")
      when :branch
        b = Branch.create(name: params[:groupable_name], score: 0, region_id: params[:groupable_id])
        MyGroup.create(user_id: @user.id, role: "guide", my_groupable_id: b.id, my_groupable_type: "Branch")
      when :group
        g = Group.create(name: params[:groupable_name], score: 0, branch_id: params[:groupable_id])
        MyGroup.create(user_id: @user.id, role: "guide", my_groupable_id: g.id, my_groupable_type: "Group")
      end
    else
      if roles.key(params[:type]) == :kid
        MyGroup.create(user_id: @user.id, role: "kid", my_groupable_id: params[:groupable_id], my_groupable_type: "Group")
      else
        MyGroup.create(user_id: @user.id, role: "guide", my_groupable_id: params[:groupable_id], my_groupable_type: roles.key(params[:type]).to_s.capitalize())
      end
    end

    puts "Created MyGroup!"
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
