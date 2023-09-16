# Library that contains TCPServer
require "socket"

# global variables
player1 = nil
player2 = nil
players = []
active_player = nil
column = nil
ready_to_begin = false

# Create a new instance of TCPServer on Port 3333
server = TCPServer.new("0.0.0.0", 3333)

def params(request, key)
  path = request.split[1]
  params = path.split(key + "=")
  params[-1]
end

def send_response(connection, output)
  # require 'byebug'; byebug
  # Generate the Response
  puts "Sending response."
  status = if output == "bad request"
    "http/1.1 400 bad request"
  else
    "http/1.1 200 ok"
  end
  response = status + "\r\n\r\n" + output
  # Send the Response
  puts response
  connection.puts response
end

loop do
  # Wait for a Request
  # When a request comes in, save the connection to a variable
  puts "Waiting for Request..."
  connection = server.accept
  # Read the request line by line until we have read every line
  puts "Got this Request:"
  line = connection.gets.chomp
  request_lines = []

  until line.empty?
    request_lines << line
    line = connection.gets.chomp
  end

  # Print out the Request
  puts request_lines

  # Extract the parameter if the Request included a guess
  request_line = request_lines[0]

  case
  when request_line.include?("/init")
    plyr = params(request_line, "player")
    if player1 == nil
      player1 = plyr
      players << player1
    else
      player2 = plyr
      players << player2
      ready_to_begin = true
    end
    send_response(connection, "you need to be patient")

  when request_line.include?("/start")
    requester = params(request_line, "player")
    if ready_to_begin
      # require 'pry'; binding.pry
      foe = players.reject { |player| player == requester }.first
      send_response(connection, "start #{foe} #{player1}")
    else
      send_response(connection, "patience please")
    end

  when request_line.include?("/move")
    # request in format <IP:PORT>/move?player=player?column=column
    active_player = params(request_line, "player").split("?")[0]
    column = params(request_line, "column")
    send_response(connection, "good move young padawan")

  when request_line.include?("/status")
    requester = params(request_line, "player")
    if requester != active_player && !active_player.nil?
      send_response(connection, column.to_s)
    else
      send_response(connection, "patience please")
    end

  when request_line.include?("/reset")
    player1 = nil
    player2 = nil
    players = []
    active_player = nil
    column = nil
    ready_to_begin = false

  else
    send_response(connection, "bad request")
  end

  # close the connection
  connection.close
end
