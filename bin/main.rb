require 'telegram/bot'
require './lib/ui_tictac'
require './lib/logic_bot'
require './lib/player'

TOKEN = '1723295532:AAG4CclSM9lsDBAZFTSKTzIKxdWFZUnl3RU'.freeze

ANSWERS = ['hey try /start', 'of course, now try /start', 'yeah bro, try /start', 'or you can try start',
           'print start hehe'].freeze

def send_message(bot, ms, text = nil)
  bot.api.send_message(
    chat_id: ms.chat.id,
    text: text
  )
end

Telegram::Bot::Client.run(TOKEN) do |bot|
  mscounter = 0
  interface = UI_game.new
  game_logic = interface.game_logic
  player = game_logic.player
  bot.listen do |message|
    player.name = message.from.first_name
    mscounter += 1
    if mscounter == 1
      send_message(bot, message,
                   "Hey, #{player.name} \nI wanna play with you a tic tac toe game, do you? (y/n)")
    else
      response = game_logic.check_message(message.text)
      p "response = #{response}"
      mess = nil
      case response
      when 'start'
        mess = interface.start_game
        send_message(bot, message, mess)
        board = interface.draw_board
        send_message(bot, message, board)
      when 'numbers'
        mess = interface.key_board
        question = 'Choose an available number from the board:'
        answers =
          Telegram::Bot::Types::ReplyKeyboardMarkup.new(
            keyboard: mess,
            one_time_keyboard: true
          )
        bot.api.sendMessage(chat_id: message.chat.id, text: question, reply_markup: answers)
        board = interface.draw_board
        send_message(bot, message, board)
      when 'game-over'
        if game_logic.winner == 'DRAW'
          mess = "It's a DRAW"
        elsif
          mess = "#{game_logic.winner} is winner!"
        end
        mess += "\nIf you wanna restart the game type start"
        interface = UI_game.new
        game_logic = interface.game_logic
        player = game_logic.player
        send_message(bot, message, mess)
      when 'end'
        interface = UI_game.new
        game_logic = interface.game_logic
        player = game_logic.player
        mess = interface.finish_game
        send_message(bot, message, mess)
      when 'numbers-error'
        mess = 'please select an available number from the board'
        send_message(bot, message, mess)
      else
        mess = ANSWERS.sample
        send_message(bot, message, mess)
      end

    end
  end
end
