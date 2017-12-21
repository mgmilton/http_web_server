require './test/helper_test'
require './lib/server'
require 'faraday'

class ServerTest < Minitest::Test

  def test_server_instantiates
    server = Server.new
    assert_instance_of Server, server
  end

  def test_server_generates_response
    response = Faraday.get "http://127.0.0.1:9292/"
    assert_equal '', response
  end
end
