require 'socket'
require './lib/response'

requests = 0
hellos = 0
server = TCPServer.new(9292)
loop do
  client = server.accept
  puts "Ready for a request"
  request_lines = []
  while line = client.gets and !line.chomp.empty?
    request_lines << line.chomp
  end
  puts "Got this request:"
  puts request_lines.inspect
  path = "#{request_lines[0].split[1]}"
  case
  when path == "/"
    requests +=1
    specific_response ="
    Verb: #{request_lines[0].split[0]}
    Path: #{request_lines[0].split[1]}
    Protocol: #{path}
    Host: #{request_lines[1].split[1]}
    Port: #{request_lines[1].split(":")[2]}
    Origin: #{request_lines[1].split[1]}
    Accept #{acceptance = request_lines.select do |line|
                            line.include?("Accept:")
                          end
                          s=acceptance.to_s.split[1]
                          s.delete("\"]")}"
    response = "<pre>" + specific_response + "</pre>"
  when path == "/hello"
    requests += 1
    hellos += 1
    response = "<pre>" + "Hello, World! (#{hellos})" + "</pre>"
  when path == "/datetime"
    requests += 1
    response = "</pre>" + "#{Time.now.strftime('%I:%M%p on %A, %B %e, %Y')}" + "</pre>"
  when path == "/shutdown"
    requests +=1
    response = "</pre>" + "Total Requests: #{requests}" + "</pre>"
  end
  puts "Sending response."
  output = "<html><head></head><body>#{response}</body></html>"
  headers = ["http/1.1 200 ok",
            "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
            "server: ruby",
            "content-type: text/html; charset=iso-8859-1",
            "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  client.puts headers
  client.puts output

  puts ["Wrote this response:", headers, output].join("\n")
  client.close
  puts "\nResponse complete, exiting."
end
