require 'telegram/bot'
require_relative 'state'
require 'dotenv'
Dotenv.load

class TelegramServer
  TOKEN = ENV['TOKEN']
  USER_ID = ENV['USER_ID']
  
  @bot = nil
  @chat_id = nil

  def self.run(queue)
    Telegram::Bot::Client.run(TOKEN) do |bot|
      @bot = bot
      bot.listen do |message|
        @chat_id = message.chat.id
        case message.text
        when '/start'
          self.message("Hello, I'm your bot!")
        when 'Wake'
          queue.push(:awaken)
        when 'Sleep'
          queue.push(:go_to_bed)
        end
      end
    end
  end

  def self.message(text)
    return unless @bot && @chat_id
    send_message(@bot, text)
  end


  def self.send_message(bot, text)
    kb = [
      Telegram::Bot::Types::KeyboardButton.new(text: 'Wake'),
      Telegram::Bot::Types::KeyboardButton.new(text: 'Sleep')
    ]
    markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: [kb], resize_keyboard: true, one_time_keyboard: false)
    bot.api.send_message(chat_id: USER_ID, text: text, reply_markup: markup)
  end
end
