require 'telegram/bot'
require_relative 'ui_tictac.rb'
require_relative 'player.rb'
#require './bin/main.rb'

class GameLogic
  attr_accessor :play, :player 
  attr_reader :bot_player, :players
  def initialize
    @play = false
    @player = Player.new
    @bot_player = Player.new('smart_bot')
    @players = [@player, @bot]
  end

    def play?(bool=nil)
        if bool.nil?
          return play
        end
        raise ArgumentError unless !!bool == bool
        play = bool
        play
    end

    def check_message(mess = nil)
      case mess
        when '/start', 'y', 'yes', 'yeah', 'yep', 'start'
          unless play? != false
            play?(true)
            try = Random.new.rand(2)
            if try == 1
              @player.symbol = "X"
              @bot_palyer = "O"
            else
              @player.symbol = "O"
              @bot_palyer = "X"
            end
            return 'start'
          end
        when '1', '2', '3', '4', '5', '6', '7', '8', '9'
          p "there is a number = #{mess} and play is = #{play?}"
          if play?
            return 'numbers'
          end
        when '/end', '/close', 'no', 'end', 'n'
          play = false
          return 'end'
        else
          return 'numbers-error'
        end
      end

      def self.prepare_data(choice)
        
      end
    


end