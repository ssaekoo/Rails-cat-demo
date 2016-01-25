require 'socket'
require 'thread'
require 'json'

$cats = []
$id = 0

Thread.abort_on_exception = true

server = TCPServer.new(3000)

def handle_request(socket)
  Thread.new do
    cmd = socket.gets.chomp

    case cmd
    when "INDEX"
      socket.puts $cats.to_json
    when "SHOW"
      cat_id = Integer(socket.gets.chomp)
      cat = $cats.find {|cat| cat[:id] == cat_id }
      socket.puts cat.to_json
    when "CREATE"
      name = socket.gets.chomp
      cat_id = $id
      $id += 1
      $cats << { id: cat_id, name: name }
    when "UPDATE"
      cat_id = Integer(socket.gets.chomp)
      cat = $cats.find {|cat| cat[:id] == cat_id }

      new_name = socket.gets.chomp
      cat[:name] = new_name
    when "DESTROY"
      cat_id = Integer(socket.gets.chomp)
      $cats.reject! { |cat| cat[:id] == cat_id }
    end
    # socket.puts("Thanks for connecting")
    # socket.puts("What is your name, human?")
    # name = socket.gets.chomp
    #
    # socket.puts("Goodbye #{name}")
    socket.close
  end
  puts "Spawned worker thread"
end

while true
  socket = server.accept
  handle_request(socket)
end
