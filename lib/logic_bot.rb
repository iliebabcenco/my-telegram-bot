require 'telegram/bot'
require_relative 'ui_tictac'
require_relative 'player'

class GameLogic
  attr_accessor :play, :player, :winner
  attr_reader :bot_player, :players

  def initialize
    @play = false
    @player = Player.new
    @bot_player = Player.new('smart_bot')
    @players = [@player, @bot_player]
    @winner = nil
  end

  def check_message(mess = nil)
    if @play
      case mess
      when '1', '2', '3', '4', '5', '6', '7', '8', '9'
        numbers_logic(mess)
      when '/end', '/close', 'no', 'end', 'n', 'N'
        Player.reset_choices
        @play = false
        'end'
      when String
        'numbers-error'
      end
    else
      case mess
      when 'y', 'yes', 'yeah', 'yep', 'start', 'Start', 'Start!', 'Y'
        accept_logic
      else
        'error'
      end
    end
  end

  private

  def play?(bool = nil)
    return @play if bool.nil?
    raise ArgumentError unless !bool.nil? == bool

    @play = bool
    @play
  end

  def accept_logic
    return unless @play == false

    @play = true
    set_symbols
    bot_player.make_choice(bot_logic_choice) if bot_player.symbol == 'X'
    'start'
  end

  def numbers_logic(mess)
    cur_length = player.answers.length
    player.make_choice(mess) unless check_winner
    return 'numbers-error' if player.answers.length == cur_length && !check_winner

    bot_player.make_choice(bot_logic_choice) unless check_winner
    check_winner
    if @winner.nil?
      'numbers'
    else
      Player.reset_choices
      @play = false
      'game-over'
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
    good_choices = []
    if bot_player.answers.length.zero?
      good_start = [1, 3, 7, 9, 5]
      bot_choice = good_start[Random.new.rand(0..4)]
      bot_choice = good_start[Random.new.rand(0..4)] while player.answers.include?(bot_choice)
      return bot_choice
    end
    
    bot_good_choice
    #return available_choices[Random.new.rand(0..available_choices.length - 1)] if available_choices.length.positive?
  end

  def bot_good_choice
    win_answers = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    answers = bot_player.answers
    available_choices = check_board
    max = answers.length
    good_choices = []

    good_choices.each do |x|
      if x.length == 1 && available_choices.include?(x[0])
        return x[0]
      end
    end
    
    win_answers.each do |each| 
      if each.include?(answers[0])
        good_choices.push(each - answers)
      end
    end
    p "there is good choices = #{good_choices} bot answers #{answers} available #{available_choices}"
    
    return check_next(good_choices)
  end

  def check_next(good_choices)
    available_choices = check_board
    return available_choices[Random.new.rand(0..available_choices.length - 1)] if good_choices.length == 0
    
    until available_choices.include?(good_choice)
      good_choice_arr = good_choices[Random.new.rand(0..good_choices.length-1)]
      if good_choice_arr.length >= 2
        good_choice = good_choice_arr[Random.new.rand(0..1)]
        next_elem_gc = good_choice_arr[(good_choice_arr.index(good_choice)-1).abs]
        p "good choices = #{good_choices} good_choice_arr = #{good_choice_arr} good_choice = #{good_choice} and next is = #{next_elem_gc}"
        until available_choices.include?(next_elem_gc)
          good_choice_arr = good_choices[Random.new.rand(0..good_choices.length-1)]
          good_choice = good_choice_arr[Random.new.rand(0..1)]
          next_elem_gc = good_choice_arr[(good_choice_arr.index(good_choice)-1).abs]
          p "good_choice = #{good_choice} and next is = #{next_elem_gc}"
        end
      elsif available_choices.include?(good_choice)
        good_choice = good_choice_arr[0]
      end
    end
    return good_choice
  end

  # def check_chances(player)
  #   win_answers = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  #   answers = player.answers
  #   available_choices = check_board
  #   return 'low' if answers.lenght <= 1

  # end

  def check_board
    Player.choices.select { |x| x.is_a? Integer }
  end
end
