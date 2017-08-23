class SessionsController < Devise::SessionsController
  respond_to :json

  # POST /users/sign_in
  def create
    self.resource = warden.authenticate(auth_options)

    if self.resource
      set_flash_message(:notice, :signed_in) if is_flashing_format?
      sign_in(resource_name, resource)
      yield resoure if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      # redirect differently for users and admin 
      if params[:user][:password] == 'password'
        set_flash_message(:alert, :invalid)
        redirect_to root_path
      else
        set_flash_message(:alert, :invalid_admin)
        redirect_to new_user_session_path
      end
    end
  end
end
