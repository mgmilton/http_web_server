require 'socket'
tcp_server = TCPServer.new(9292)
client = tcp_server.accept
visits = 0
while true
  Thread.new(tcp_server.accept) do |connection|
    puts "Accepting connection from: #{connection.peeraddr[2]}"
    begin
      while connection
        incomingData = connection.gets("\0")
        if incomingData != nil
          incomingData = incomingData.chomp
        end

        puts "Incoming Data: #{incomingData}"

        if incomingData == "DISCONNECT\0"
          puts "Recieved: DISCONNECT, closed connection"
          connection.close
          break
        else
          connection.puts "You said: #{incomingData}"
          connection.flush
        end
      end
    rescue Exception => e
      puts "#{e} (#{e.class})"
    ensure
      connection.close
      puts "ensure: Closing"
    end
  end
end
