require 'telegram/bot'

TOKEN = '1723295532:AAG4CclSM9lsDBAZFTSKTzIKxdWFZUnl3RU'

ANSWERS = ["hey try /start", "of course, now try /start", "yeah bro, try /start"]

Telegram::Bot::Client.run(TOKEN) do |bot|
    bot.listen do |message|
        case message.text
        when '/start', '/start start'
            bot.api.send_message(
            chat_id: message.chat.id, 
            text: "Hey, #{message.from.first_name} \nI wanna play with you a tic tac toe game, do you?")
        else
            bot.api.send_message(
            chat_id: message.chat.id, 
            text: ANSWERS.sample)
        end
    end
end