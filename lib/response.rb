require './lib/game'

class Response
  attr_reader :game, :hellos

  def initialize
    @hellos = -1
    @game = game
  end

  def hello
    @hellos += 1
    "Hello, World! (#{@hellos/2})"
  end

  def datetime
   "#{Time.now.strftime('%I:%M%p on %A, %B %e, %Y')}"
  end

  def shutdown(request)
    argument_raiser(request)
    "Total requests: #{request}"
  end

  def word_search(word)
    argument_raiser(word, String)
    dictionary = File.read("/usr/share/dict/words").split
    if dictionary.include?(word.downcase)
      "#{word.upcase} is a known word"
    else
      "#{word.upcase} is not a known word"
    end
  end

  def start_game
    @game = Game.new
    "Good Luck!"
  end

  def argument_raiser(datatype, desiredclass = Integer)
    if datatype.class != desiredclass
      raise ArgumentError
    end
  end
end
