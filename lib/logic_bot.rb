require 'telegram/bot'
require_relative 'ui_tictac'
require_relative 'player'

class GameLogic
  attr_accessor :play, :player
  attr_reader :bot_player, :players

  def initialize
    @play = false
    @player = Player.new
    @bot_player = Player.new('smart_bot')
    @players = [@player, @bot]
  end

  def play?(bool = nil)
    return @play if bool.nil?
    raise ArgumentError unless !!bool == bool

    @play = bool
    @play
  end

  def check_message(mess = nil)
    case mess
    when '/start', 'y', 'yes', 'yeah', 'yep', 'start'
      p "we are in check message when start, play is #{play?}"
      if @play == false
        @play = true
        try = Random.new.rand(2)
        if try == 1
          @player.symbol = 'X'
          @bot_palyer = 'O'
        else
          @player.symbol = 'O'
          @bot_palyer = 'X'
        end
        'start'
      end
    when '1', '2', '3', '4', '5', '6', '7', '8', '9'
      player.make_choice(mess)
      return 'numbers' if @play
    when '/end', '/close', 'no', 'end', 'n'
      @play = false
      'end'
    else
      'numbers-error'
    end
  end

  def self.prepare_data(choice); end
end
