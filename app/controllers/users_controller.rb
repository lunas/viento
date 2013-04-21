class UsersController < ApplicationController

  before_filter :authenticate_user!

  def index
    @page_title = t('users.index.title')
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    @page_title = t("users.edit.title")
    @display_passwords = (@user != current_user)
  end

  def update
    @user = User.find(params[:id])

    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
      params[:user].delete(:current_password)
      if @user.update_attributes(params[:user])
        redirect_to users_path, notice: t('users.update.updated')
      else
        @page_title = t("users.edit.title")
        render action: :edit
      end
    else
      if @user.update_with_password(params[:user])
        RegistrationsController::sign_in :user, @user, bypass: true
        redirect_to users_path, notice: t('users.update.updated')
      else
        @page_title = t("users.edit.title")
        render action: :edit
      end
    end
  end

  def destroy
    @user= User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

end
