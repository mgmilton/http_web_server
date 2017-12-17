require 'socket'
server = TCPServer.new(9292)
visits =0
loop do
  visits+=1
  socket = server.accept

  request = socket.gets

  STDERR.puts request

  response = "Hello World! (#{visits})"

  socket.print "HTTP/1.1 200 OK\r\n" +
               "Content-Type: text/plain\r\n" +
               "Content-Length: #{response.bytesize}\r\n"
               "Connection: close\r\n"

  socket.print "\r\n"

  socket.print response


  socket.close
end
