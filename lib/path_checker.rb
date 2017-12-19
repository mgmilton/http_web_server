class PathChecker
  def initialize(path)
    @path = path
  end

  def root?
    path == "/"
  end

  def hello?
    path == "/hello"
  end

  def datetime?
    path == "/datetime"
   # Time.now.strftime('%I:%M%p on %A, %B %e, %Y')
  end

  def shutdown?
    path == "shutdown"
  end

  def game?
    path == "/game"
  end

  def start_game?
    path == "/startgame"
  end

  def word_search?
    path == "/word_search"
  end
end
