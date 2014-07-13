class Email

  # Almonst unnecessary anymore, now... but still used in EmailsController

  attr_reader :username
  attr_accessor :referer, :message

  def initialize(username, referer, message = nil)
    @username = username
    @referer = referer
    @message = message
  end

end