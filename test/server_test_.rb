require './test/helper_test'
require './lib/server'
require 'faraday'

class ServerTest < Minitest::Test

  def setup
    @parser = Parser.new
    @server = Server.new
  end

  def test_server_instantiates
    assert_instance_of Server, @server
  end

  def test_web_responder_get_no_path_returns_diagnostics
    response = Faraday.get "http://127.0.0.1:9292"
    assert_equal "<html><head></head><body><pre>\nVerb: GET\nPath: /\nProtocol: HTTP/1.1\nHost: Faraday\nPort: \nOrign: Faraday\nAccept: */*\n</pre></body></html>" , response.body
  end

  def test_headers_returns_request_headers
    response = Faraday.get "http://127.0.0.1:9292"

    headers = @server.headers(200).split("\r\n")[1..3]
    faraday_headers = response.env.response_headers.to_a.flatten
    faraday_headers.each_with_index do |value, index|
      faraday_headers[index] = "#{faraday_headers[index]}: #{faraday_headers[index+1]}"
       faraday_headers.delete(faraday_headers[index+1])
    end.delete_at(-1)


    assert_equal faraday_headers, headers
  end

  def test_force_error_raises_error
    skip
    response = Faraday.get "http://127.0.0.1:9292/force_error"

    assert_equal "<html><head></head><body>HTTP/1.1 500 Internal Server Error</body></html>", response.body
  end

  def test_get_game_evaluates_guess
    start_game = Faraday.post "http://127.0.0.1:9292/start_game"

    guess = Faraday.get "http://127.0.0.1:9292/game"

    assert_equal "<html><head></head><body>Your most recent guess 0 was too low. You've made 0 guesses.</body></html>", guess.body
  end

  def test_word_search_correctly_identifies_words
    word = Faraday.get "http://127.0.0.1:9292/word_search?word=denim"

    assert_equal "<html><head></head><body>DENIM is a known word</body></html>", word.body
  end

  def test_word_search_correctly_identifies_non_words
    word = Faraday.get "http://127.0.0.1:9292/word_search?word=dssm"

    assert_equal "<html><head></head><body>DSSM is not a known word</body></html>", word.body
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
