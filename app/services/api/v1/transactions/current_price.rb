class Api::V1::Transactions::CurrentPrice < Api::V1::BaseService
  require 'net/http'
  require 'uri'
  require 'json'
  def self.call
    fetch_btc_price
  end

  def self.fetch_btc_price
    url = URI('https://api.coindesk.com/v1/bpi/currentprice.json')
    response = Net::HTTP.get(url)
    data = JSON.parse(response)
    response = build_success('Precio actual del Bitcoin obtenido con éxito.', data['bpi']['USD']['rate_float'])
    { response:, status: response[:status] }
  rescue StandardError => e
    puts "Error fetching Bitcoin price: #{e.message}"
    build_error(e.messages)
    { response:, status: response[:status] }
  end
end
