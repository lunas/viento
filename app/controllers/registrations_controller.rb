class RegistrationsController < Devise::RegistrationsController

  # GET /resource/sign_up
  #def new
  #  super
  #end

  # POST /resource
  def create
    @page_title = t('actions.new_user')
    super
  end

  # GET /resource/edit
  def edit
    @page_title = t('users.edit.profile')
    @user = resource
    @display_passwords = true
    render :edit
  end

  # DELETE /resource
  def destroy
    @page_title = t('actions.delete_user')
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  #def cancel
  #  super
  #end

end
