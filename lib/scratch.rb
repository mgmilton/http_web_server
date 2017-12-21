

def path_finder(verb, path, response, request, client, requests, body)
  path = parser.path(request)
  verb = parser.verb(request)
  if path == "/" && verb == "GET"
    web_response = "#{diagnostics(parser, request)}"
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


def response_formatter(path, verb)
  if path == "/" & verb == "GET"
    response.hello
