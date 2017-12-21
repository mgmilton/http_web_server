
class Game
  attr_reader :number, :guesses

  def initialize
    @number = rand(0..100)
    @guesses = 0
  end

  def hi_low(guess)
    @guesses += 1
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
