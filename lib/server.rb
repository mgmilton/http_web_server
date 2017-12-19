require 'socket'

class Server

  def initialize
    @requests = 0
    @hellos = 0
  end

  def start_server
    server = TCPServer.new(9292)
    loop do
      puts "Ready for a request"
      client = server.accept
      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
      puts "Got request:"
      @requests += 1
      puts request_lines.inspect
      path_finder(request_lines, client)
      break if path_finder(request_lines, client) == "shut down server"
      client.close
    end
  end

  def diagnostics(request_lines)
    verb_path_and_protocol = request_lines[0].split
    host = request_lines[1].split[1]
    port = request_lines[1].split(":")[2]
    accept = request_lines[6].split[1]
    [
      "<pre>",
      "Verb: #{verb_path_and_protocol[0]}",
      "Path: #{verb_path_and_protocol[1]}",
      "Protocol: #{verb_path_and_protocol[2]}",
      "Host: #{host}",
      "Port: #{port}",
      "Orign: #{host}",
      "Accept: #{accept}",
      "</pre>"
    ].join("\n")
  end

  def path_finder(request_lines, client)
    case request_lines[0].split[1]
    when "/"
      @requests += 1
      client.puts diagnostics(request_lines)
    when "/hello"
      @requests += 1
      @hellos += 1
      response = "Hello, World! (#{@hellos})"
      output = "<html><head></head><body>#{response}</body></html>"
      client.puts diagnostics(request_lines)
      client.puts output
    when "/datetime"
      @requests += 1
      response = "#{Time.now.strftime('%I:%M%p on %A, %B %e, %Y')}"
      output = "<html><head></head><body>#{response}</body></html>"
      client.puts diagnostics(request_lines)
      client.puts output
    when "/shutdown"
      @requests +=1
      response = "Total Requests: #{@requests}"
      output = "<html><head></head><body>#{response}</body></html>"
      client.puts diagnostics(request_lines)
      client.puts output
      "shut down server"
    end
  end
end
