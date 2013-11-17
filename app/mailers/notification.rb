class Notification < ActionMailer::Base
  default from: 'ghxstnotes@gmail.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.send_test_mail.subject
  #
  def send_test_mail(current_value, user)
    @user = user
    @current_values = current_value

    mail to: 'ghostnotesdot@gmail.com', subject: 'Currency Exchange Rate'
  end
end
