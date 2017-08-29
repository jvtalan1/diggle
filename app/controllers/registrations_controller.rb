class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def profile
    @user = current_user
    if @user
      render :profile
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    unless @user.update(params[:user].permit(:email, :password, :password_confirmation, user_profile_attributes: [:username, :full_name, :phone_number, :location, :picture, :id]))
      render :profile
      return
    end
    redirect_to authenticated_root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :remember_me])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, user_profile_attributes: [:username, :full_name, :phone_number, :location, :picture]])
  end

end
