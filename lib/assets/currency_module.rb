require 'uri'
require 'net/https'
require 'json'
require 'nokogiri'
require 'open-uri'

module Currency
  JPY = 'JPY'

  GBP = 'GBP'
  USD = 'USD'
  EUR = 'EUR'
  AUD = 'AUD'
  CAD = 'CAD'
  CHF = 'CHF'

  CURRENCIES = [
    JPY, USD, EUR, AUD, GBP, CAD, CHF,
  ]

  class CurrencyExchangeScrapingFailedException < StandardError; end

  def self.get_current_value(from, to)
    currency_exchange_getter = CurrencyExchangeGetter.new
    currency_exchange_getter.get_current_value(from, to)
  end

  def self.get_current_values(to)
    currency_exchange_getter = CurrencyExchangeGetter.new
    currency_exchange_getter.get_current_values(to)
  end

  class CurrencyExchangeGetter
    def get_current_value(from, to)
      get_current_value_via_yahoo(from, to)
    end

    def get_current_values(to)
      get_current_values_via_yahoo(to)
    end

    private

    def get_current_value_via_yahoo(from, to)
      doc = Nokogiri::HTML(open("http://info.finance.yahoo.co.jp/exchange/convert/?a=1&s=#{from}&t=#{to}"))

      if doc.css('table').length > 0
        table = doc.css('table').first

        {
          from: from,
          to: to,
          from_value: 1.00,
          to_value: to_float(table.css('strong').text)
        }
      else
        raise CurrencyExchangeScrapingFailedException.new('Probably the site design has been changed.')
      end
    end

    def get_current_values_via_yahoo(to)
      doc = Nokogiri::HTML(open('http://info.finance.yahoo.co.jp/exchange/'))

      table = doc.search('//table').first
      table_row = table.search('//tr')[1]

      current_values = {}
      table_row.css('.strong > a').each_with_index do |anchor, index|
        current_values[CURRENCIES[index + 1]] = anchor.content.to_s
      end

      current_values
    end

    def to_float(value)
      valid_current_value_format(value)
      value.to_f
    end

    def valid_current_value_format(value)
      if value !~ /^\d+\.\d+$/
        raise CurrencyExchangeScrapingFailedException.new("Scraped an unexpected format current value => [#{value}]")
      end
    end
  end
end