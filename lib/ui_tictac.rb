require_relative 'player'

class UI_game
  attr_accessor :board, :keyboard
  attr_reader :game_logic

  def initialize
    @game_logic = GameLogic.new
    @board = Player.choices
    # @board = %w[1 2 3 4 5 6 7 8 9]
    @keyboard = [[@board[0].to_s, @board[1].to_s, @board[2].to_s], [@board[3].to_s, @board[4].to_s, @board[5].to_s],
                 [@board[6].to_s, @board[7].to_s, @board[8].to_s], ['end']]
  end

  def key_board
    [[@board[0].to_s, @board[1].to_s, @board[2].to_s], [@board[3].to_s, @board[4].to_s, @board[5].to_s],
     [@board[6].to_s, @board[7].to_s, @board[8].to_s], ['end']]
  end

  def draw_board(_choice = nil)
    "+-----+-----+-----+\n |  #{@board[0]}  |  #{@board[1]}  |  #{@board[2]}  |\n+-----+-----+-----+\n |  #{@board[3]}  |  #{@board[4]}  |  #{@board[5]}  |\n+-----+-----+-----+\n |  #{@board[6]}  |  #{@board[7]}  |  #{@board[8]}  |\n+-----+-----+-----+"
  end

  def start_game
    "Ok, let's start the game, there are instructions\n
  1. You were randomly set to play with #{game_logic.player.symbol}\n
  2. Choose an available number from the board and try to win;\n
  3. If you wanna finish the game try: /end, /close, no, end, n\n
  4. Gool luck and have fun!\n"
  end

  def finish_game
    "Game finished, thank you for the game!\nType start if you wanna play again"
  end
end
