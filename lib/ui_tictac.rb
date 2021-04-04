module UItictac
  @@board = %w[1 2 3 4 5 6 7 8 9]
  @@keyboard = [[@@board[0], @@board[1], @@board[2]], [@@board[3], @@board[4], @@board[5]],
  [@@board[6], @@board[7], @@board[8]]]

  def self.draw_board(choice = nil)
    @@board[choice.to_i - 1] = 'X' if choice.to_i.is_a? Integer
    
    p @@board
    p "there is @@board[choice.to_i - 1] #{@@board[choice.to_i - 1]} and it is a integer = #{choice.to_i.is_a? Integer}"

    @@keyboard
    
  end

  def self.start_game(_param = nil)
    'game started'
  end

  def self.finish_game(_param = nil)
    'game finished'
  end
end
