class Parser

  def initialze
    attr_reader :web_info

    @web_info = { path: nil,
                  verb: nil,
                  host: nil,
                  word_finder: nil,
                  content_length: nil,
                  number: nil
    }
  end

  def path(request_lines)
    argument_raiser(request_lines)
    @web_info[:path] = request_lines[0].split[1].split("?")[0]
  end

  def verb(request_lines)
    argument_raiser(request_lines)
    @web_info[:verb] = request_lines[0].split[0]
  end

  def host(request_lines)
    argument_raiser(request_lines)
    @web_info[:host] = request_lines[1].split[1]
  end

  def word_finder(request_lines)
    argument_raiser(request_lines)
    @web_info[:word_finder] = request_lines[0].split[1].split("?")[1].split("=")[0]
  end

  def content_length(request_lines)
    argument_raiser(request_lines)
    @web_info[:content_length] = request_lines[3].split(": ")[1].to_i
  end

  def guess_getter(body)
    @web_info[:number] = body.split[4].to_i
  end

  def formatter(request_lines)
    path(request_lines)
    verb(request_lines)
    host(request_lines)
    word_finder(request_lines)
    content_length(request_lines)
  end

  def argument_raiser(datatype, desiredclass = Array)
    if datatype.class != desiredclass
      raise ArgumentError
    end
  end

end
