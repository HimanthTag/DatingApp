class Users::PasswordsController < Devise::PasswordsController
  prepend_before_filter :require_no_authentication
  append_before_filter :assert_reset_token_passed, :only => :edit
  # GET /resource/password/new
  def new
    super
  end

  # POST /resource/password
  def create
   self.resource = resource_class.send_reset_password_instructions(resource_params)

    if successfully_sent?(resource)
      #flash[:notice] => "You will receive an email with instructions on how to reset your password in a few minutes."
      #redirect_to root_path, :notice => "Instruction has been send to your email"
      render :json => { :status => true, :message => "You will receive an email with instructions on how to reset your password in a few minutes."}
    else
      #respond_with(resource)
      render :json => { :status => false, :message => "Email is not found."}
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    super
  end

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message(:notice, flash_message) if is_navigational_format?
      sign_in(resource_name, resource)
      redirect_to edit_user_path(resource), :notice => "Password has been changed."
    else
      respond_with resource
    end
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(resource_name)
    super(resource_name)
  end

  def assert_reset_token_passed
    super
  end

  def unlockable?(resource)
    super
  end
  
end
