require 'telegram/bot'
require_relative '../lib/ui_tictac'
require_relative '../lib/logic_bot'
require_relative '../lib/player'
require_relative '../lib/hide_token'

token = TOKEN

ANSWERS = ['hey try /start, (if type start and messages like this repeats, bot is busy with another player)',
           'of course, now try /start (if type start and messages like this repeats, bot is busy with another player)',
           'yeah, try /start (if type start and messages like this repeats, bot is busy with another player)',
           'or you can try start (if type start and messages like this repeats, bot is busy with another player)',
           'print start hehe (if type start and messages like this repeats, bot is busy with another player)'].freeze

private

def send_message(bot, mes, text = nil)
  bot.api.send_message(
    chat_id: mes.chat.id,
    text: text
  )
end

def send_keyboard(bot, message, keyboard_type, text_message)
  answers =
    Telegram::Bot::Types::ReplyKeyboardMarkup.new(
      keyboard: keyboard_type,
      one_time_keyboard: true
    )
  bot.api.sendMessage(
    chat_id: message.chat.id,
    text: text_message,
    reply_markup: answers
  )
end

Telegram::Bot::Client.run(token) do |bot|
  mscounter = 0
  interface = UIgame.new
  game_logic = interface.game_logic
  player = game_logic.player
  bot.listen do |message|
    player.name = message.from.first_name
    time = Time.now
    p "#{player.name} is now started the game"
    mscounter += 1
    if mscounter == 1
      key_type = %w[yes no]
      text_message = "Hey, #{player.name} \nI wanna play with you a tic tac toe game, do you? (y/n)"
      send_keyboard(bot, message, key_type, text_message)
    else
      response = game_logic.check_message(message.text)
      case response
      when 'start'
        send_message(bot, message, interface.start_game)
        send_keyboard(bot, message, interface.key_board, interface.draw_board)
      when 'numbers'
        send_keyboard(bot, message, interface.key_board,
                      "Is #{player.name}'s turn (#{player.symbol}), choose an available number from the board:")
        send_message(bot, message, interface.draw_board)
      when 'game-over'
        send_message(bot, message, interface.draw_board)
        answer = if game_logic.winner == 'DRAW'
                   "It's a DRAW\nIf you wanna restart the game type start"
                 else
                   "#{game_logic.winner} is winner!\nIf you wanna restart the game type start"
                 end
        interface = UIgame.new
        game_logic = interface.game_logic
        player = game_logic.player
        send_keyboard(bot, message, 'Start!', answer)
        p "player #{player.name} is at game over at #{Time.now - time}"
      when 'end'
        interface = UIgame.new
        game_logic = interface.game_logic
        player = game_logic.player
        send_keyboard(bot, message, 'Start!', interface.finish_game)
        p "player #{player.name} is at end at #{Time.now - time}"
      when 'numbers-error'
        send_keyboard(bot, message, interface.key_board,
                      "'#{message.text}' is not a good choice please select an available number from the board.")
        send_message(bot, message, interface.draw_board)
        p "player #{player.name} is at numbers-error at #{Time.now - time}"
      when 'error'
        send_message(bot, message, ANSWERS.sample)
        p "player #{player.name} is at error at #{Time.now - time}"
      end
    end
  end
end
