class Users::RegistrationsController < Devise::RegistrationsController
before_action :configure_sign_up_params, only: [:create]
before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # # PUT /resource
  # def update
  #   # p "registrations controller update user params"
  #   # p params[:user]
  #   super
  # end
  def update
    @user = User.find(current_user.id)
    # email_changed = @user.email != params[:user][:email]
    is_facebook_account = !@user.provider.blank?

    successfully_updated = if !is_facebook_account
      @user.update_with_password(allowed_params)
    else
      @user.update_without_password(allowed_params)
    end

    if successfully_updated
      # Sign in the user bypassing validation in case his password changed
      # sign_in @user, :bypass => true
      redirect_to registration_path
    else
      redirect_to registration_path      
    end
  end

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
  def configure_sign_up_params
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :current_password, :names, :surnames, :area_of_residence_id, :area_of_interest_id])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:email, :password, :password_confirmation, :current_password, :names, :surnames, :area_of_residence_id, :area_of_interest_id)
    end
  end

  def allowed_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :names, :surnames, :area_of_residence_id, :area_of_interest_id)
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
