class ConfirmationsController < Devise::ConfirmationsController

  private

  def after_confirmation_path_for(resource_name, resource)
    sign_in(resource)
    edit_user_path(resource)
  end
end
