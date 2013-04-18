class UsersController < ApplicationController

  before_filter :authenticate_user!

  def index
    @page_title = t('users.index.title')
    @users = User.all
  end

  def edit
    @page_title = t('users.edit')
    @user = User.find(params[:id])
  end

  def new
    @page_title = t('users.new')
    @user = User.new()
  end
end
