class EmailsController < ApplicationController

  before_filter :authenticate_user!

  def new
    @page_title = t('email.title')
    @email = Email.new( current_user.username, URI(request.referer).path )
  end

  def create
    @email = Email.create(params[:email])
    begin
      raise "Nachricht fehlt" if @email.empty?
      @email.deliver
      notice = t('email.sent')
    rescue Exception => e
      notice = t('email.failed', error: e.message)
    end
    redirect_to @email.referer, notice: notice
  end

end
