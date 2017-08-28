class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation, :remember_me])
    devise_parameter_sanitizer.permit(:account_update, keys: [:password, :password_confirmation, :full_name, :username, :phone_number, :location, :picture])
  end

end
