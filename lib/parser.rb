class Parser
  attr_reader :path, :verb

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

  def word_finder(request_lines)
    argument_raiser(request_lines)
    request_lines[0].split[1].split("?")[1].split("=")[1]
  end

  def argument_raiser(datatype, desiredclass = Array)
    if datatype.class != desiredclass
      raise ArgumentError
    end
  end

end
