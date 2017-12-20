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
  
end
