class SendEmail

  include Sidekiq::Worker
  include ActionView::Helpers

  def perform(email)
    begin
      raise 'Nachricht fehlt' if email['message'].nil?
      email = sanitize(email)
      UserMailer.feedback_email(email[:username], email[:referer], email[:message]).deliver
      Rails.logger.info t('email.sent')
    rescue => e
      Rails.logger.error e.message
    end
  end

  def sanitize(dirty)
    dirty.inject({}) do |memo,pair|
      memo[pair.first.to_sym] = ActionController::Base.helpers.sanitize(pair.last)
      memo
    end
  end

end