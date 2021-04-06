require 'telegram/bot'
require_relative 'ui_tictac'
require_relative 'player'

class GameLogic
  attr_accessor :play, :player
  attr_reader :bot_player, :players, :winner

  def initialize
    @play = false
    @player = Player.new
    @bot_player = Player.new('smart_bot')
    @players = [@player, @bot_player]
    @winner = nil
  end

  def play?(bool = nil)
    return @play if bool.nil?
    raise ArgumentError unless !bool.nil? == bool

    @play = bool
    @play
  end

  def check_message(mess = nil)
    if @play == true
      case mess
      when '1', '2', '3', '4', '5', '6', '7', '8', '9'
        if @play
          make_move(mess)
          if @winner.nil?
            'numbers'
          else
            Player.reset_choices
            'game-over'
          end
        else
          'numbers-error'
        end
      when '/end', '/close', 'no', 'end', 'n', 'N'
        Player.reset_choices
        @play = false
        'end'
      end
    else
      case mess
      when 'y', 'yes', 'yeah', 'yep', 'start', 'Start', 'Start!', 'Y'
        if @play == false
          @play = true
          set_symbols
          bot_player.make_choice(bot_logic_choice) if bot_player.symbol == 'X'
          'start'
        end
      else
        'error'
      end
    end
  end

  def set_symbols
    try = Random.new.rand(2)
    if try == 1
      @player.symbol = 'X'
      @bot_player.symbol = 'O'
    else
      @player.symbol = 'O'
      @bot_player.symbol = 'X'
    end
  end

  def make_move(choice = nil)
    unless check_winner
      player.make_choice(choice)
    end
    unless check_winner
      bot_player.make_choice(bot_logic_choice)
    end
  end

  def check_winner
    answers = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    answers.each do |sub_array|
      intersection = sub_array & player.answers
      intersection2 = sub_array & bot_player.answers
      if intersection == sub_array
        @play = false
        @winner = player.name
        return true
      elsif intersection2 == sub_array
        @play = false
        @winner = bot_player.name
        return true
      end
    end
    if bot_player.answers.length >= 5 || player.answers.length >= 5
      @play = false
      @winner = 'DRAW'
      return true
    end

    false
  end

  def bot_logic_choice
    available_choices = check_board
    bot_choice = nil
    if bot_player.answers.length.zero?
      good_start = [1, 3, 7, 9, 5]
      bot_choice = good_start[Random.new.rand(0..4)]
      bot_choice = good_start[Random.new.rand(0..4)] while player.answers.include?(bot_choice)
      return bot_choice
    end
    available_choices[Random.new.rand(0..available_choices.length - 1)] if available_choices.length.positive?
  end

  def check_board
    Player.choices.select { |x| x.is_a? Integer }
  end
end
