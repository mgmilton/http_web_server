class Parser

  def request(request_lines)
    request_lines
  end

  def path(request_lines)
    request_lines[0].split[1].split("?")[0]
  end

  def verb(request_lines)
    request_lines[0].split[0]
  end

  def host(request_lines)
    request_lines[1].split[1]
  end

  def word_finder(request_lines)
    request_lines[0].split[1].split("?")[1].split("=")[1]
  end

end
