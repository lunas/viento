class UsersController < ApplicationController

  before_filter :authenticate_user!

  def index
    @users = User.all
    #@settings = Settings.new
  end

  # create another user (as opposed to self registration)
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to users_path, notice: t('users.update.updated')
    else
      @page_title = t("actions.new_user")
      render action: 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    @page_title = t("users.edit.title")
    @display_passwords = (@user != current_user)
  end

  def new
    @user = User.new
    @page_title = t("actions.new_user")
  end

  def update
    @user = User.find(params[:id])

    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
      params[:user].delete(:current_password)
    end

    if @user.update_attributes(params[:user])
      redirect_to users_path, notice: t('users.update.updated')
    else
      @page_title = t("users.edit.title")
      render action: :edit
    end
  end

  def destroy
    @user= User.find(params[:id])
    if @user.destroy
      flash[:notice] = t('users.destroy.deleted')
    else
      flash[:error] = @user.errors[:base].join(', ')
    end

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

end
