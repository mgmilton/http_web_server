require 'socket'
require './lib/parser'
require './lib/response'

class Server
  attr_reader :response, :parser, :requests, :body


  def initialize
    @output = ""
  end

  CODES = {
    200 => "HTTP/1.1 200 OK",
    301 => "HTTP/1.1 301 Moved Permanently",
    403 => "HTTP/1.1 403 Forbidden",
    404 => "HTTP/1.1 404 Not Found",
    500 => "HTTP/1.1 500 Internal Server Error"
  }

  SystemError = "You broke the internet!"

  def start_server
    server = TCPServer.new(9292)
    @parser = Parser.new
    @response = Response.new
    @requests = 0
    loop do
      puts "Ready for request:"
      client = server.accept
      request = store_request(client)
      @requests += 1
      @body = client.read(@parser.content_length(request))
      if web_responder(request, client) == "shut down server"
        break
      else
        web_responder(request, client)
      end
      client.close
    end
  end

  def store_request(client)
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    request_lines
  end

  def diagnostics(request)
    ["<pre>",
      "Verb: #{@parser.verb(request)}",
      "Path: #{@parser.path(request)}",
      "Protocol: #{@parser.protocol(request)}",
      "Host: #{@parser.host(request)}",
      "Port: #{@parser.port(request)}",
      "Orign: #{@parser.host(request)}",
      "Accept: #{@parser.accept(request)}",
      "</pre>"].join("\n")
  end

  def redirect(code)
    headers = [CODES[code],
              "location: http://localhost:9292/game",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1\r\n\r\n"].join("\r\n")
  end

  def headers(code)
      headers = [CODES[code],
                "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                "server: ruby",
                "content-type: text/html; charset=iso-8859-1",
                "content-length: #{@output.length}\r\n\r\n"].join("\r\n")
  end
  
  def web_responder(request, client)
    path = @parser.path(request)
    verb = @parser.verb(request)
    if path == "/" && verb == "GET"
      web_response = "#{diagnostics(request)}"
      output_formatter(client, web_response, 200)
    elsif path == "/hello" && verb == "GET"
      web_response = "<pre>" + @response.hello + "</pre>"
      output_formatter(client, web_response, 200)
    elsif path == "/datetime" && verb == "GET"
      web_response = @response.datetime
      output_formatter(client, web_response, 200)
    elsif path == "/word_search" && verb == "GET"
      web_response = @response.word_search(@parser.word_finder(request))
      output_formatter(client, web_response, 200)
    elsif path == "/start_game" && verb == "POST"
      game_checker(@response, client)
    elsif path == "/game" && verb == "GET"
      web_response = @response.game.hi_low(@response.game.current_guess)
      output_formatter(client, web_response, 200)
    elsif path == "/game" && verb == "POST"
      guess_poster
      client.puts redirect(301)
    elsif path == "/shutdown"
      web_response = response.shutdown(@requests)
      output_formatter(client, web_response, 200)
      shut_down
    elsif path == '/force_error'
      output_formatter(client, CODES[500], 500)
      raise SystemError
    else
      output_formatter(client, CODES[404], 404)
    end
  end

  def game_checker(response, client)
    if @response.game.nil?
      web_response = @response.start_game
      output_formatter(client, web_response, 301)
    else
      output_formatter(client, CODES[403], 403)
    end
  end

  def guess_poster
    @response.game.store_guess(@parser.guess_getter(@body))
  end

  def shut_down
    "shut down server"
  end

  def output_formatter(client, web_response, code)
    @output = "<html><head></head><body>#{web_response}</body></html>"
    client.puts headers(code)
    client.puts @output
  end

end
