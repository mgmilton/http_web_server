
class Game
  attr_reader :number, :guesses
  attr_accessor :current_guess

  def initialize
    @number = rand(0..100)
    @guesses = -1
    @current_guess = 0
  end

  def store_guess(guess)
    @current_guess = guess
    @guesses += 1
  end

  def hi_low(guess)
    case
    when guess < @number
      "Your #{@number} most recent guess #{guess} was too low. You've made #{@guesses/2 + 1} guesses."
    when guess > @number
      "Your most recent guess #{guess} was too high. You've made #{@guesses/2 + 1} guesses."
    when guess == @number
      "Correct!"
    end
  end


end
