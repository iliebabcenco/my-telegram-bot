require_relative 'player.rb'

class UI_game
  attr_accessor :board, :keyboard
  attr_reader :game_logic

  def initialize
    @game_logic = GameLogic.new
    @board = Player.choices
    #@board = %w[1 2 3 4 5 6 7 8 9]
    @keyboard = [[@board[0], @board[1], @board[2]], [@board[3], @board[4], @board[5]],
                 [@board[6], @board[7], @board[8]]]
  end

  def key_board(_choice = nil)
    @keyboard
  end

  def draw_board(choice = nil)
    p "there is choice #{choice}"
    p "there is @board[choice.to_i - 1] #{@board[choice.to_i - 1]}"
    @board[choice.to_i - 1] = 'X' if choice.to_i.is_a? Integer
    "+-----+-----+-----+\n|  #{@board[0]}  |  #{@board[1]}  |  #{@board[2]}  |\n+-----+-----+-----+\n|  #{@board[3]}  |  #{@board[4]}  |  #{@board[5]}  |\n+-----+-----+-----+\n|  #{@board[6]}  |  #{@board[7]}  |  #{@board[8]}  |\n+-----+-----+-----+"
  end

  def start_game(_param = nil)
    "Ok, let's start the game, there are instructions\n
  1. You were randomly set to play with #{game_logic.player.symbol}\n
  2. Choose an available number from the board and try to win:\n
  3. If you wanna finish the game try: /end, /close, no, end, n\n
  4. Gool luck and have fun!"
  end

  def finish_game(param = nil)
    return 'Game finished, thank you for the game!' if param.nil?
  end
end
