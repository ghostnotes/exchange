require "#{Rails.root}/lib/assets/currency_module"
require "#{Rails.root}/lib/assets/exchange_module"

namespace :currency_exchange_rate do
  task test: :environment do
    puts 'am testing the task of exchange...'
  end

  task send_email: :environment do
    send_test_email
  end

  private

  def send_test_email
    unless Exchange::DayChecker.is_available_wday?(Date.today)
      return
    end

    unless Exchange::TimeChecker.is_available_time?
      return
    end

    user = {
      first_name: 'Kimio',
      last_name: 'Taniguchi',
    }

    current_values = Currency.get_current_values(Currency::JPY)
    Notification.send_test_mail(current_values, user).deliver
  end
end
