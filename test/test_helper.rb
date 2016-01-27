$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'one45'
load "config/application.rb"
require 'minitest/autorun'
require 'minitest/reporters'
require 'webmock/minitest'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "test/cassettes"
  c.hook_into :webmock
end

Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)

class Minitest::Test
  def setup
    One45.api_host = API_HOST
    One45.client_key = CLIENT_KEY
    One45.client_secret = CLIENT_SECRET
    One45.access_token = ACCESS_TOKEN
  end
end
