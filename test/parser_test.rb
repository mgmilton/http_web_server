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
    assert_equal 'fast', parse.word_finder(["path/ path?word=fast"])
  end

  def test_protocol_splits_first_element_by_second_space
    parse = Parser.new
    assert_equal "e", parse.protocol(["a b e", "d s"])
  end

  def test_protocol_only_accepts_arrays
    parse = Parser.new
    assert_raises ArgumentError do
      parse.protocol(3.3)
    end

    assert_raises ArgumentError do
      parse.protocol("no_one_will_read_this_string")
    end
  end

  def test_port_splits_second_element_by_colon_returns_proceeding_characters
    parse = Parser.new
    assert_equal "f", parse.port(["ab: e", "a: d:f"])
  end

  def test_port_only_accepts_arrays
    parse = Parser.new
    assert_raises ArgumentError do
      parse.port(3.3)
    end

    assert_raises ArgumentError do
      parse.port("no_one_will_read_this_string")
    end
  end

  def test_accept_returns_characters_preceeding_accept_and_colon
    parser = Parser.new
    assert_equal "Chocolate", parser.accept(["No Colon", "Accept: Chocolate"])
  end

  def test_accept_only_allows_arrays
    parse = Parser.new
    assert_raises ArgumentError do
      parse.accept(3.3)
    end

    assert_raises ArgumentError do
      parse.accept("no_one_will_read_this_string")
    end
  end

  def test_content_length_returns_integer_proceeding_colon_of_third_element_in_array
    parse = Parser.new
    assert_equal 3, parse.content_length(["la",'de',"da","dum: 3"])
  end

  def test_content_length_returns_length_of_webpage_in_bytes
    parse = Parser.new
    assert_equal 138, parse.content_length(["path","location","server","content_length: 138"])
  end

  def test_content_lenght_only_accepts_arrays
    parse = Parser.new
    assert_raises ArgumentError do
      parse.content_length(3.3)
    end

    assert_raises ArgumentError do
      parse.content_length("no_one_will_read_this_string")
    end
  end

  def test_guess_getter_returns_fifth_character_as_integer
    parse = Parser.new
    assert_equal 4, parse.guess_getter("a b 4 33 4")
  end

  def test_guess_getter_only_accepts_strings
    parse = Parser.new
    assert_raises ArgumentError do
      parse.guess_getter(0.2)
    end

    assert_raises ArgumentError do
      parse.guess_getter([3,"a,g", "i love my dad"])
    end
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
