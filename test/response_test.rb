require './test/helper_test'
require './lib/response'

class ResponseTest < Minitest::Test

  def test_response_instantiates
    response = Response.new
    assert_instance_of Response, response
  end

  def test_response_starts_with_negative_one_hello
    response = Response.new
    assert_equal -1, response.hellos
  end

  def test_hello_returns_a_string
    response = Response.new
    assert_equal String, response.hello.class
  end

  def test_hello_returns_string_with_hello_count
    response = Response.new
    assert_equal "Hello, World! (0)", response.hello
  end

  def test_datetime_returns_a_string
    response = Response.new
    assert_equal String, response.datetime.class
  end

  def test_datetime_returns_a_string_with_current_time
    response = Response.new
    assert_equal "#{Time.now.strftime('%I:%M%p on %A, %B %e, %Y')}", response.datetime
  end

  def test_shutdown_returns_a_string
    response = Response.new
    assert_equal String, response.shutdown(3).class
  end

  def test_shutdown_only_accepts_integers
    response = Response.new
    assert_raises ArgumentError do
      response.shutdown("a")
    end
  end

  def test_shutdown_returns_string_with_total_requests
    response = Response.new
    assert_equal "Total requests: 3", response.shutdown(3)
  end

  def test_word_search_raises_argument_when_passed_a_float
    response = Response.new
    assert_raises ArgumentError do
      response.word_search(0.2)
    end
  end

  def test_word_search_raises_argument_when_passed_an_array
    response = Response.new
    assert_raises ArgumentError do
      response.word_search([0.2])
    end
  end

  def test_word_search_raises_argument_when_passed_an_integer
    response = Response.new
    assert_raises ArgumentError do
      response.word_search(2)
    end
  end

  def test_word_search_returns_string_stating_word_is_in_dictionary
    response = Response.new
    assert_equal "ORANGUTAN is a known word", response.word_search("orangutan")
  end

  def test_word_search_returns_string_stating_word_is_not_in_dictionary
    response = Response.new
    assert_equal "HOOP-DEE is not a known word", response.word_search("hoop-dee")
  end

  def test_argument_raiser_raises_argument_when_passed_a_float
    response = Response.new
    assert_raises ArgumentError do
      response.argument_raiser(0.2)
    end
  end

  def test_argument_raiser_raises_argument_when_passed_a_string
    response = Response.new
    assert_raises ArgumentError do
      response.argument_raiser('s')
    end
  end

  def test_argument_raiser_raises_argument_when_passed_an_array
    response = Response.new
    assert_raises ArgumentError do
      response.argument_raiser(['ad'])
    end
  end

  def test_start_game_returns_good_luck
    response = Response.new
    assert_equal "Good Luck!", response.start_game
  end

  def test_start_game_instantiates_a_game
    response = Response.new
    response.start_game
    assert_instance_of Game, response.game
  end
end
