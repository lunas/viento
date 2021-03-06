class EmailsController < ApplicationController

  before_filter :authenticate_user!

  def new
    @page_title = t('email.title')
    @email = Email.new( current_user.username, URI(request.referer).path )
  end

  def create
    SendEmail.perform_async params[:email].to_h
    referer = ActionController::Base.helpers.sanitize params[:email][:referer]
    redirect_to referer, notice: t('email.scheduled')
  end

end
