require 'telegram/bot'

TOKEN = '1723295532:AAG4CclSM9lsDBAZFTSKTzIKxdWFZUnl3RU'

ANSWERS = ["YES", "OF COURSE", "YEAH BRO"]

Telegram::Bot::Client.run(TOKEN) do |bot|
    bot.listen do |message|
        case message.text
        when '/start', '/start start'
            bot.api.send_message(
            chat_id: message.chat.id, 
            text: "hey, #{message.from.first_name}")
        else
            bot.api.send_message(
            chat_id: message.chat.id, 
            text: ANSWERS.sample)
        end
    end
end