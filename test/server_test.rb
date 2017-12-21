require './test/helper_test'
require './lib/server'
require 'faraday'

class ServerTest < Minitest::Test

  def test_server_instantiates
    server = Server.new
    assert_instance_of Server, server
  end



  def test_web_responder_post_start_game_sends_a_redirect_followed_by_403
    response = Faraday.post "http://127.0.0.1:9292/start_game"
    assert_equal 301, response.status
    require 'pry' ; binding.pry
    new_response = Faraday.post "http://127.0.0.1:9292/start_game"
    assert_equal 403, new_response.status
  end



end
