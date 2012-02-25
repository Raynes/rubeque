class RegistrationsController < Devise::RegistrationsController

  def update
    if params[resource_name][:password].blank?
      params[resource_name].delete(:password)
      params[resource_name].delete(:password_confirmation) if params[resource_name][:password_confirmation].blank?
    end
    # Override Devise to use update_attributes instead of update_with_password.
    # This is the only change we make.
    if resource.user_tokens.empty? && (resource.update_with_password(params[resource_name]))
      set_flash_message :notice, :updated
      # Line below required if using Devise >= 1.2.0
      sign_in resource_name, resource, :bypass => true
      redirect_to after_update_path_for(resource)
    elsif resource.user_tokens.any? && resource.update_attributes(params[resource_name])
      set_flash_message :notice, :updated
      # Line below required if using Devise >= 1.2.0
      sign_in resource_name, resource, :bypass => true
      redirect_to after_update_path_for(resource)
    else
      # TODO: we keep getting duplicate error messages for email
      clean_up_passwords(resource)
      render "devise/registrations/edit"
    end
  end
  
end
