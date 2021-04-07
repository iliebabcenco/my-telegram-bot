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
    if bot_player.answers.length.zero?
      good_start = [1, 3, 7, 9, 5]
      bot_choice = good_start[Random.new.rand(0..4)]
      bot_choice = good_start[Random.new.rand(0..4)] while player.answers.include?(bot_choice)
      return bot_choice
    end

    bot_good_choice
  end

  def bot_good_choice
    win_answers = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    good_choices = []
    return check_player if check_player.is_a? Integer

    length_logic(win_answers, good_choices)

    good_choices.each do |x|
      next unless x.length == 1 && check_board.include?(x[0])

      return x[0]
    end
    return check_next(good_choices) if good_choices.length > 1
    return check_board[Random.new.rand(0..check_board.length - 1)] if check_board.length.positive?
  end

  def length_logic(win_answers, good_choices)
    if bot_player.answers.length == 1
      win_answers.each do |each|
        good_choices.push(each - bot_player.answers) if each.include?(bot_player.answers[0])
      end
    end

    return unless bot_player.answers.length >= 2

    win_answers.each do |each|
      subarr = each - bot_player.answers
      subaru = subarr & check_board
      return subaru[0] if subaru.length == 1
    end
  end

  def check_next(good_choices)
    available_choices = check_board
    good_choice_arr = good_choices[Random.new.rand(0..good_choices.length - 1)]
    good_choice = good_choice_arr[Random.new.rand(0..1)]
    next_elem_gc = good_choice_arr[(good_choice_arr.index(good_choice) - 1).abs]
    until available_choices.include?(good_choice) && available_choices.include?(next_elem_gc)
      good_choice_arr = good_choices[Random.new.rand(0..good_choices.length - 1)]
      good_choice = good_choice_arr[Random.new.rand(0..1)]
      next_elem_gc = good_choice_arr[(good_choice_arr.index(good_choice) - 1).abs]
    end
    good_choice
  end

  def check_player
    return unless player.answers.length >= 2

    win_answers = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    win_answers.each do |each|
      next unless (player.answers - each).empty? || (each - player.answers).empty?

      subarr = each - player.answers
      subaru = subarr & check_board
      return subaru[0]
    end
  end

  def check_board
    Player.choices.select { |x| x.is_a? Integer }
  end
end
