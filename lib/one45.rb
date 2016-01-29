require "one45/version"

# Dependencies
require "restclient"

# Common
require "one45/base"

# API resources
require "one45/evaluations"
require "one45/events"
require "one45/forms"
require "one45/groups"
require "one45/questions"
require "one45/rotations"
require "one45/users"

# Errors
require "one45/errors/one45_error"


module One45
  VERBS = %w(get post put)

  class << self
    attr_accessor :api_host, :client_key, :client_secret, :access_token

    def generate_token(client_key, client_secret)
      params = { params: { client_key: client_key, client_secret: client_secret} }
      begin
        response = RestClient.get(token_url, params)
        @access_token = JSON.parse(response)['access_token']
        # puts "generated access_token: #{@access_token}"
        @access_token
      rescue => e
        One45Error.new("#{e.class} - #{e.response}")
      end
    end

    def api_url
      "https://#{One45.api_host}/web/one45_stage.php/api/v1"
    end

    def token_url
      "https://#{One45.api_host}/web/one45_stage.php/api/token/generate"
    end

    VERBS.each do |verb|
      define_method verb do |path, *params|
        send_request(verb, path, *params)
      end
    end

  private

    def validate_configuration
      [@api_host, @client_key, @client_secret].each do |config|
        raise One45Error.new("api_host, client_key or client_secret not set") if config.nil?
      end
    end

    def send_request(verb, path, options = {})
      validate_configuration

      url = path.start_with?('http') ? path : api_url + "/#{path}"

      url = URI::encode(url)

      params = format_body_params(options, @access_token) if @access_token

      begin
        response = RestClient.send(verb, url, params)
      rescue RestClient::Unauthorized
        # token may be expired or nil
        # submit request again with a fresh token
        @access_token = generate_token(@client_key, @client_secret)
        params = format_body_params(options, @access_token)
        response = RestClient.send(verb, url, params)
      rescue => e
        One45Error.new("error: #{e.class} : #{e.response} : #{e.response}")
      end

      JSON.parse response if response && response.length >= 2
      # http://stackoverflow.com/questions/8390256/a-json-text-must-at-least-contain-two-octets
    end

    def format_body_params(options, access_token)
      # insert access_token in the original hash
      token_hash = { access_token: access_token }
      options.merge! token_hash
      # nest options under the key 'params'
      params = { params: options }
    end

    def default_headers
      { 'Content-Type' => "application/json",
        'Accept' => "application/json" }
    end
  end
end
