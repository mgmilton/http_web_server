class PathEvaluator
  def initialize
    @hellos = -1
  end

  def hello
    @hellos += 1
    "Hello, World! (#{@hellos})"
  end

  def datetime
   "#{Time.now.strftime('%I:%M%p on %A, %B %e, %Y')}"
  end

  def shutdown(request)
    "Total requests: #{request}"
  end

  def word_search(word)
    dictionary = File.read("/usr/share/dict/words").split
    if dictionary.include?(word.downcase)
      "#{word.upcase} is a known word"
    else
      "#{word.upcase} is not a known word"
    end
  end

  def game?
  end

  def start_game?
  end

end
