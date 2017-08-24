class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected

  def after_sign_up_path_for(resource)
    edit_user_registration_path(resource)
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:password, :password_confirmation, :full_name, :username, :phone_number, :location, :picture])
  end

end
