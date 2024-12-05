require "net/http"
require "json"

class HomeController < ApplicationController

  CURRENCIES = [
    { code: 'USD-BRL' },
    { code: 'EUR-BRL' },
    { code: 'BTC-BRL' }
  ]

  def index
    @chart_data = []

    CURRENCIES.each do |currency|
      url = URI("https://economia.awesomeapi.com.br/json/daily/#{currency[:code]}/30")
      response = Net::HTTP.get(url)
      data =  JSON.parse(response)

      hash = {}
      data.each do |entry|
        date = Time.at(entry['timestamp'].to_i).strftime("%d/%m/%Y")
        rate = entry['high']

        hash[date] = rate
      end

      @chart_data << { name: currency[:code] , data: hash }
    end

  end

end
