class Email
  include ActionView::Helpers

  attr_reader :username
  attr_accessor :referer, :message

  def initialize(username, referer, message = nil)
    @username = username
    @referer = referer
    @message = message
  end

  def self.create(attributes)
    clean = attributes.inject({}) {|memo,pair| memo[pair.first.to_sym] = ActionController::Base.helpers.sanitize(pair.last); memo}
    Email.new(clean[:username], clean[:referer], clean[:message])
  end

  def deliver
    UserMailer.feedback_email(@username, @referer, @message).deliver
  end

  def empty?
    return @message.empty?
  end

end