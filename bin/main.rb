require 'telegram/bot'
require './lib/ui_tictac'
require './lib/logic_bot'

TOKEN = '1723295532:AAG4CclSM9lsDBAZFTSKTzIKxdWFZUnl3RU'.freeze

ANSWERS = ['hey try /start', 'of course, now try /start', 'yeah bro, try /start', 'or you can try start',
           'print start hehe'].freeze
include UItictac
include Lgtictac



def send_message(bot, ms, text = nil)
  bot.api.send_message(
    chat_id: ms.chat.id,
    text: text
  )
  
end

Telegram::Bot::Client.run(TOKEN) do |bot|
  mscounter = 0
  bot.listen do |message|
    
    mscounter += 1
    response = Lgtictac.check_message(message.text)
    mess = nil
   
    if mscounter == 1
      send_message(bot, message,
                   "Hey, #{message.from.first_name} \nI wanna play with you a tic tac toe game, do you? (y/n)")
    else
      case response
        when '/start', 'y', 'yes', 'yeah', 'yep'
          mess = UItictac.start_game
          bot.api.send_message(
            chat_id: message.chat.id,
            text: mess
          )
        when '1', '2', '3', '4', '5', '6', '7', '8', '9'
          mess = UItictac.draw_board(response)
          question = 'choose a number:'
          answers =
            Telegram::Bot::Types::ReplyKeyboardMarkup.new(
              keyboard: mess,
              one_time_keyboard: true
            )
          bot.api.sendMessage(chat_id: message.chat.id, text: question, reply_markup: answers)
        when '/end', '/close', 'no', 'end'
          mess = UItictac.finish_game(response)
          send_message(bot, message, mess)
        else
          mess = 'unknown command, try /start, /start start, start /end, /close, no'
          send_message(bot, message, mess)
      end
      
    end
    
  end
end
