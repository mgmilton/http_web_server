class Parser

  def request(request_lines)
    request_lines
  end

  def path(request)
    request[0].split[1].split("?")[0]
  end

  def verb(request)
    request[0].split[0]
  end

  def host(request)
    request[1].split[1]
  end

  def params(request)
    request[0].split[1].split("?")[1].split("=")[1]
  end
end
