require 'socket'
require './lib/parser'
require './lib/path_evaluator'

class Server
  def start_server
    server = TCPServer.new(9292)
    parser = Parser.new
    path_response = PathEvaluator.new
    requests = 0
    loop do
      puts "Ready for a request"
      client = server.accept
      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
      puts "Got request:"
      puts request_lines.inspect
      if path_finder(parser, path_response, request_lines, client, requests) == "shut down server"
        break
      else
        path_finder(parser, path_response, request_lines, client, requests)
      end
      client.close
    end
  end

  def diagnostics(request_lines)
    verb_path_and_protocol = request_lines[0].split
    host = request_lines[1].split[1]
    port = request_lines[1].split(":")[2]
    accept = request_lines[6].split[1]
    ["<pre>",
      "Verb: #{verb_path_and_protocol[0]}",
      "Path: #{verb_path_and_protocol[1]}",
      "Protocol: #{verb_path_and_protocol[2]}",
      "Host: #{host}",
      "Port: #{port}",
      "Orign: #{host}",
      "Accept: #{accept}",
      "</pre>"].join("\n")
  end

  def path_finder(parser, path_response, request_lines, client, requests)
    case parser.path(request_lines)
    when "/"
      requests += 1
      client.puts diagnostics(request_lines)
    when "/hello"
      requests += 1
      response = "<pre>" + path_response.hello + "</pre>"
      output = "<html><head></head><body>#{response}</body></html>"
      client.puts diagnostics(request_lines)
      client.puts output
    when "/datetime"
      requests += 1
      response = path_response.datetime
      output = "<html><head></head><body>#{response}</body></html>"
      client.puts diagnostics(request_lines)
      client.puts output
    when "/word_search"
      requests += 1
      word = parser.word_finder(request_lines)
      response = path_response.word_search(word)
      output = "<html><head></head><body>#{response}</body></html>"
      client.puts diagnostics(request_lines)
      client.puts output
    when "/shutdown"
      requests +=1
      response = path_response.shutdown(requests)
      output = "<html><head></head><body>#{response}</body></html>"
      client.puts diagnostics(request_lines)
      client.puts output
      "shut down server"
    end
  end
end
