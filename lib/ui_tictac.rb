class UI_game

  attr_accessor :board, :keyboard
  attr_reader :game_logic

  def initialize
    @game_logic = GameLogic.new
    @board = %w[1 2 3 4 5 6 7 8 9]
    @keyboard = [[@board[0], @board[1], @board[2]], [@board[3], @board[4], @board[5]],
    [@board[6], @board[7], @board[8]]]
  end

  def draw_board(choice = nil)
    @board[choice.to_i - 1] = 'X' if choice.to_i.is_a? Integer
    
    p @board
    p "there is @board[choice.to_i - 1] #{@board[choice.to_i - 1]} and it is a integer = #{choice.to_i.is_a? Integer}"

    @keyboard
    
  end

  def start_game(_param = nil)
    "ok, let's start the game, there are instructions \n1. You were randomly set to play with #{game_logic.player.symbol}\n2. Choose an available number from the board and try to win: 
          \n3. If you wanna finish the game try: /end, /close, no, end, n \n4. Gool luck and have fun!"
  end

  def finish_game(_param = nil)
    'game finished'
  end
end
