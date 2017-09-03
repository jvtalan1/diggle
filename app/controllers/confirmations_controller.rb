class ConfirmationsController < Devise::ConfirmationsController

  private

  def after_confirmation_path_for(resource_name, resource)
    sign_in(resource)
    edit_profile_path(resource)
  end
end
