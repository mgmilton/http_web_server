require 'socket'
require './lib/parser'
require './lib/response'

class Server
  attr_reader :requests, :number

  def initialize
    @output = ""
  end

  def start_server
    server = TCPServer.new(9292)
    parser = Parser.new
    response = Response.new
    requests = 0
    loop do
      client = server.accept
      parsed_request = store_request(client)
      requests += 1
      body = client.read(parser.content_length(request))
      if path_finder(response, parsed_request, client, requests, body) == "shut down server"
        break
      else
        path_finder(response, parsed_request, client, requests, body)
      end
      client.close
    end
  end

  def store_request(client)
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    parsed_request = parser.formatter(request_lines)
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

  def redirect
    headers = ['HTTP/1.1 301 Moved Permanently',
              'location: http://localhost:9292/game',
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1\r\n\r\n"].join("\r\n")
  end

  def headers
      headers = ["http/1.1 200 ok",
                "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                "server: ruby",
                "content-type: text/html; charset=iso-8859-1",
                "content-length: #{@output.length}\r\n\r\n"].join("\r\n")
  end

  def path_finder(parser, response, request, client, requests, body)
    path = parser.path(request)
    verb = parser.verb(request)
    if path == "/" && verb == "GET"
      web_response = "#{diagnostics(request_lines)}"
      @output = "<html><head></head><body>#{web_response}</body></html>"
      client.puts headers
      client.puts @output
    elsif path == "/hello" && verb == "GET"
      web_response = "<pre>" + response.hello + "</pre>"
      @output = "<html><head></head><body>#{web_response}</body></html>"
      client.puts headers
      client.puts @output
    elsif path == "/datetime" && verb == "GET"
      web_response = response.datetime
      @output = "<html><head></head><body>#{web_response}</body></html>"
      client.puts headers
      client.puts @output
    elsif path == "/word_search" && verb == "GET"
      word = parser.word_finder(request_lines)
      web_response = response.word_search(word)
      @output = "<html><head></head><body>#{web_response}</body></html>"
      client.puts headers
      client.puts @output
    elsif path == "/start_game" && verb == "POST"
      web_response = response.start_game
      @output = "<html><head></head><body>#{web_response}</body></html>"
      client.puts headers
      client.puts @output
    elsif path == "/game" && verb == "GET"
      web_response = response.game_status(parser.guess_getter(number))
      @output = "<html><head></head><body>#{web_response}</body></html>"
      client.puts headers
      client.puts @output
    elsif path == "/game" && verb == "POST"
      web_response = response.game_status(parser.guess_getter(body))
      @output = "<html><head></head><body>#{web_response}</body></html>"
      client.puts headers
      client.puts @output
      #client.puts redirect
    elsif path == "/shutdown"
      web_response = response.shutdown(requests)
      @output = "<html><head></head><body>#{web_response}</body></html>"
      client.puts headers
      client.puts @output
      "shut down server"
    end
  end

end
