class ContactUs < ActionMailer::Base
  default from: "tickets@hopeforchange.org"

  def message_email(message)
      @message = message
      mail(to: APP_CONFIG[:contact_us_email], subject: "[Usherette] Message from #{message.email}")
  end
end
