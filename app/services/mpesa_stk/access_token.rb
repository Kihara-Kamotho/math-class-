require 'base64'
require 'json'
require 'dotenv/load'
require 'faraday'
require 'uri'

module MpesaStk
  class AccessToken
    @consumer_key = 'MGUnZF8sIqfqhsE0UEJO5KkhKTcX1c5p'
    @consumer_secret = '9SNySAWKbkTWl733'

    def self.call
      new.get_access_token
    end

    def get_access_token
      consumer_creds = Base64.strict_encode64('MGUnZF8sIqfqhsE0UEJO5KkhKTcX1c5p:9SNySAWKbkTWl733')
      # consumer_creds = Base64.strict_encode64('gOs8LOizK7k16DMFfFsPZS8tQdmcJQwR:uoL9Rk444EiCBGfN')
      # response
      response = Faraday.get(URI("https://sandbox.safaricom.co.ke/oauth/v1/generate?#{URI.encode_www_form(grant_type: 'client_credentials')}")) do |res|
        res.headers['Authorization'] = "Basic " + consumer_creds
        res.headers['Content-Type'] = "application/json"
      end
      
      # parse the response as JSON
      byebug
      begin
        response = JSON.parse(response.body)
      rescue JSON::ParserError => e
        # Handle the parse error here
        puts "Error parsing JSON response: #{e.message}"
      end
      
      # token
      response['access_token']
    end
  end
end
