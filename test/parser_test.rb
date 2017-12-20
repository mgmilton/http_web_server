require './test/helper_test'
require './lib/parser.rb'

class ParserTest < Minitest::Test

  def test_parser_exists
    parse = Parser.new
    assert_instance_of Parser, parse
  end

  def test_path_only_accepts_arrays
    parse = Parser.new

    assert_raises ArgumentError do
      parse.path("d")
    end

    assert_raises ArgumentError do
      parse.path(3.4)
    end
  end

  def test_path_returns_a_string
    parse = Parser.new
    assert_equal String, parse.path(["ab c"]).class
  end

  def test_path_splits_array_by_elements_and_characters
    parse = Parser.new
    assert_equal "c", parse.path(["ab c", "d"])
  end

  def test_verb_only_accepts_arrays
    parse = Parser.new

    assert_raises ArgumentError do
      parse.verb("d")
    end

    assert_raises ArgumentError do
      parse.verb(3.4)
    end
  end

  def test_verb_returns_string
    parse = Parser.new
    assert_equal String, parse.verb(["ab c"]).class
  end

  def test_verb_splits_and_returns_first_element_of_array
    parse = Parser.new
    assert_equal "ab", parse.verb(["ab c", "d"])
  end

  def test_host_only_accepts_arrays
    parse = Parser.new

    assert_raises ArgumentError do
      parse.host("d")
    end

    assert_raises ArgumentError do
      parse.host(3.4)
    end
  end

  def test_host_splits_and_returns_second_element_of_array
    parse = Parser.new
    assert_equal "d", parse.host(["ab c", "d d"])
  end

  def test_word_finder_only_accepts_arrays
    parse = Parser.new

    assert_raises ArgumentError do
      parse.word_finder("d")
    end

    assert_raises ArgumentError do
      parse.word_finder(3.4)
    end
  end

  def test_word_finder_splits_by_question_mark_and_equal_returns_first_element
    parse = Parser.new
    assert_equal 'fast', parse.word_finder(["path/ path?param=fast"])
  end

  def test_argument_raiser_raises_argument_when_passed_a_float
    parse = Parser.new
    assert_raises ArgumentError do
      parse.argument_raiser(0.2)
    end
  end

  def test_argument_raiser_raises_argument_when_passed_a_string
    parse = Parser.new
    assert_raises ArgumentError do
      parse.argument_raiser('s')
    end
  end

end
