require './test/helper_test'
require './lib/path_evaluator'

class PathEvaluatorTest < Minitest::Test

  def test_pathevaluator_instantiates
    path_eval = PathEvaluator.new
    assert_instance_of PathEvaluator, path_eval
  end

  def test_pathevaluator_starts_with_negative_one_hello
    path_eval = PathEvaluator.new
    assert_equal -1, path_eval.hellos
  end

  def test_hello_returns_a_string
    path_eval = PathEvaluator.new
    assert_equal String, path_eval.hello.class
  end

  def test_hello_returns_string_with_hello_count
    path_eval = PathEvaluator.new
    assert_equal "Hello, World! (0)", path_eval.hello
  end

  def test_datetime_returns_a_string
    path_eval = PathEvaluator.new
    assert_equal String, path_eval.datetime.class
  end

  def test_datetime_returns_a_string_with_current_time
    path_eval = PathEvaluator.new
    assert_equal "#{Time.now.strftime('%I:%M%p on %A, %B %e, %Y')}", path_eval.datetime
  end

  def test_shutdown_returns_a_string
    path_eval = PathEvaluator.new
    assert_equal String, path_eval.shutdown(3).class
  end

  def test_shutdown_only_accepts_integers
    path_eval = PathEvaluator.new
    assert_raises ArgumentError do
      path_eval.shutdown("a")
    end
  end

  def test_shutdown_returns_string_with_total_requests
    path_eval = PathEvaluator.new
    assert_equal "Total requests: 3", path_eval.shutdown(3)
  end

  def test_word_search_raises_argument_when_passed_a_float
    path_eval = PathEvaluator.new
    assert_raises ArgumentError do
      path_eval.word_search(0.2)
    end
  end

  def test_word_search_raises_argument_when_passed_an_array
    path_eval = PathEvaluator.new
    assert_raises ArgumentError do
      path_eval.word_search([0.2])
    end
  end

  def test_word_search_raises_argument_when_passed_an_integer
    path_eval = PathEvaluator.new
    assert_raises ArgumentError do
      path_eval.word_search(2)
    end
  end

  def test_word_search_returns_string_stating_word_is_in_dictionary
    path_eval = PathEvaluator.new
    assert_equal "ORANGUTAN is a known word", path_eval.word_search("orangutan")
  end

  def test_word_search_returns_string_stating_word_is_not_in_dictionary
    path_eval = PathEvaluator.new
    assert_equal "HOOP-DEE is not a known word", path_eval.word_search("hoop-dee")
  end

  def test_argument_raiser_raises_argument_when_passed_a_float
    path_eval = PathEvaluator.new
    assert_raises ArgumentError do
      path_eval.argument_raiser(0.2)
    end
  end

  def test_argument_raiser_raises_argument_when_passed_a_string
    path_eval = PathEvaluator.new
    assert_raises ArgumentError do
      path_eval.argument_raiser('s')
    end
  end

  def test_argument_raiser_raises_argument_when_passed_an_array
    path_eval = PathEvaluator.new
    assert_raises ArgumentError do
      path_eval.argument_raiser(['ad'])
    end
  end
end
