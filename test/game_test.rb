require './test/helper_test'
require './lib/game'

class GameTest < Minitest::Test

  def test_game_instantiates
    game = Game.new
    assert_instance_of Game, game
  end

  def test_game_generates_a_random_positive_interger_less_than_100
    game = Game.new
    numbers = [*0..100]
    assert numbers.include?(game.number)
  end


  def test_store_guess_logs_guess
    game = Game.new
    game.store_guess(3)
    assert_equal 3, game.current_guess
  end

  def test_store_guess_increases_guesses
    game = Game.new
    game.store_guess(4)
    assert_equal 0, game.guesses
    game.store_guess(3)
    assert_equal 1, game.guesses
  end

  def test_hi_low_evaluates_guess_relative_to_random_number
    game = Game.new
    game.store_guess(-1)
    assert_equal "Your most recent guess -1 was too low. You've made 1 guesses.", game.hi_low(-1)
    game.store_guess(101)
    assert_equal "Your most recent guess 101 was too high. You've made 1 guesses.", game.hi_low(101)
  end


  def test_hi_low_only_accepts_integers
    game = Game.new
    assert_raises ArgumentError do
      game.hi_low("orangutan")
    end
  end

  def test_argument_raiser_defaults_arguments_to_integers
    game = Game.new
    assert_raises ArgumentError do
      game.argument_raiser(['ad'])
    end

    assert_raises ArgumentError do
      game.argument_raiser(0.3)
    end
  end

end
