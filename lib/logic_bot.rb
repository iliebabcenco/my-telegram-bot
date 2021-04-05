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
    raise ArgumentError unless !!bool == bool

    @play = bool
    @play
  end

  def check_message(mess = nil)
    if @play == true
      case mess
      when '1', '2', '3', '4', '5', '6', '7', '8', '9'
        if @play
          make_move(mess)
          if !@winner.nil?
            Player.reset_choices
            return 'game-over'
          else
            return 'numbers'
          end
        else
          return 'numbers-error'
        end
      when '/end', '/close', 'no', 'end', 'n', 'N'
        Player.reset_choices
        @play = false
        'end'
      end
    else
      case mess
      when 'y', 'yes', 'yeah', 'yep', 'start', 'Start', 'Start!', 'Y'
        #p "we are in check message when start, play is #{play?}"
        if @play == false
          @play = true
          set_symbols
          if bot_player.symbol == 'X'
            bot_player.make_choice(bot_logic_choice)
          end
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
      elsif bot_player.answers.length >= 5 || player.answers.length >= 5
        @play = false
        @winner = 'DRAW'
        return true
      end
    end
    return false
  end

  def bot_logic_choice
    # if bot_player.symbol = 'X'
    available_choices = check_board
    bot_choice = nil
    #first move
    if bot_player.answers.length == 0
      good_start = [1, 3, 7, 9, 5]
     
      bot_choice = good_start[Random.new.rand(0..4)]
      while player.answers.include?(bot_choice)
        bot_choice = good_start[Random.new.rand(0..4)]
      end
      p "bot logic to choose #{bot_choice}"
      return bot_choice
    end
    if available_choices.length > 0
      return available_choices[Random.new.rand(0..available_choices.length-1)]
    else
      return
    end

  end

  def check_board
    board = Player.choices.select {|x| x.is_a? Integer}
    return board
  end

end
