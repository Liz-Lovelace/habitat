require_relative "state"
require_relative "time"
require_relative "telegram_server"

liz = State.new
command_queue = Queue.new

Thread.new do
  TelegramServer.run(command_queue)
end

liz.set_messenger(TelegramServer)

loop do
  unless command_queue.empty?
    command = command_queue.pop
    liz.send(command) if liz.respond_to?(command)
  end

  begin
    liz.advance_time T.now
  rescue StandardError => e
    puts "An error occurred: #{e.message}"
    TelegramServer.message "An error occurred: #{e.message}"
  end
  sleep 1
end

