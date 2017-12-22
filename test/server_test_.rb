require './test/helper_test'
require './lib/server'
require 'faraday'

class ServerTest < Minitest::Test

  def setup
    @parser = Parser.new
    @response = Response.new
    @server = Server.new
  end

  def test_server_instantiates
    assert_instance_of Server, @server
  end

  def test_web_responder_get_no_path_returns_diagnostics
    response = Faraday.get "http://127.0.0.1:9292/"
    assert_equal "<html><head></head><body><pre>\nVerb: GET\nPath: /\nProtocol: HTTP/1.1\nHost: Faraday\nPort: \nOrign: Faraday\nAccept: */*\n</pre></body></html>" , response.body
  end


  def test_web_responder_post_start_game_sends_a_redirect
    response = Faraday.post "http://127.0.0.1:9292/start_game"
    assert_equal 301, response.status
    new_response = Faraday.post "http://127.0.0.1:9292/start_game"
    assert_equal 403, new_response.status
  end

  def test_shut_down_returns_shut_down_string
    assert_equal "shut down server", @server.shut_down
  end

end
