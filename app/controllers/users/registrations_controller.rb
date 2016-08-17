class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        #flash[:notice] = 'You are successfully signed up'
        #flash.now[:notice] = "Signed up successfully, but you will have to verify your email"
        #sign_up(resource_name, resource)
        #sign_out(resource)
        #respond_with resource, location: edit_user_path(resource)#after_sign_up_path_for(resource)
        redirect_to new_user_session_path, notice: "You are just one step away in finding your perfect match!!!<br/>
We have sent you an email to verify your email address.<br/> Please follow the instructions in the email to complete the registration.".html_safe 
      else
        #flash.now[:notice] = "Signed up successfully, but you will have to verify your email"
        expire_data_after_sign_in!
        #respond_with resource, location: edit_user_path(resource)#after_inactive_sign_up_path_for(resource)
        redirect_to new_user_session_path, notice: "You are just one step away in finding your perfect match!!!<br/>
We have sent you an email to verify your email address.<br/> Please follow the instructions in the email to complete the registration.".html_safe 
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      flash[:alert] = resource.errors.full_messages.uniq.join('<br/>').html_safe
      redirect_to new_user_session_path
    end
  end

  # def set_flash_message!(key, kind, options = {})
  #   if is_flashing_format?
  #     set_flash_message(key, kind, options)
  #   end
  # end

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
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
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
