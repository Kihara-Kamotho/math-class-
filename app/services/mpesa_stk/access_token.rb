require 'base64'
require 'json'
require 'faraday'
require 'uri'

module MpesaStk
  class AccessToken

    def self.call
      new.get_access_token
    end

    def get_access_token
      consumer_creds = Base64.strict_encode64(encoded_keys)

      response = Faraday.get(URI(url)) do |req|
        req.params['limit'] = 100
        req.headers['Content-Type'] = 'application/json'
        req.headers['Authorization'] = "Basic #{consumer_creds}"
      end
      # byebug
      response = JSON.parse(response.body)
      response['access_token']
    end

    private

    def encoded_keys
      key = Rails.application.credentials.mpesa.fetch(:api_key)
      secret = Rails.application.credentials.mpesa.fetch(:api_secret)
      "#{key}:#{secret}"
    end

    def url
      base_url = Rails.application.credentials.mpesa.fetch(:base_url)
      token_generator_url = Rails.application.credentials.mpesa.fetch(:token_generator_url)
      "#{base_url}#{token_generator_url}"
    end
  end
end
