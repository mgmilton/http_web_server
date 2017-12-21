class Parser

  def path(request_lines)
    argument_raiser(request_lines)
    request_lines[0].split[1].split("?")[0]
  end

  def verb(request_lines)
    argument_raiser(request_lines)
    request_lines[0].split[0]
  end

  def host(request_lines)
    argument_raiser(request_lines)
    request_lines[1].split[1]
  end

  def protocol(request_lines)
    argument_raiser(request_lines)
    request_lines[0].split[2]
  end

  def port(request_lines)
    argument_raiser(request_lines)
    request_lines[1].split(":")[2]
  end

  def accept(request_lines)
    argument_raiser(request_lines)
    request_lines[6].split[1]
  end

  def word_finder(request_lines)
    argument_raiser(request_lines)
    request_lines[0].split[1].split("?")[1].split("=")[0]
  end

  def content_length(request_lines)
    argument_raiser(request_lines)
    request_lines[3].split(": ")[1].to_i
  end

  def guess_getter(body)
    body.split[4].to_i
  end

  def argument_raiser(datatype, desiredclass = Array)
    if datatype.class != desiredclass
      raise ArgumentError
    end
  end

end
