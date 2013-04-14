class UserMailer < ActionMailer::Base
  default from: Rails.configuration.feedback_sender

  def feedback_email(username, referer, message)
    @username = username
    @referer  = referer
    @message  = message
    mail(to: Rails.configuration.feedback_receiver, subject: "Viento App: Feedback")
  end

end
