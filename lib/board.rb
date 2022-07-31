class Board
  attr_accessor :board

  def initialize
    @board = [%w[_ _ _ _ _ _ _], %w[_ _ _ _ _ _ _],
              %w[_ _ _ _ _ _ _], %w[_ _ _ _ _ _ _],
              %w[_ _ _ _ _ _ _], %w[_ _ _ _ _ _ _]]
  end

  def print_board
    @board.each do |row|
      p row
    end
  end

  def lowest_space(column)
    row = @board.length - 1
    row -= 1 until @board[row][column] == '_'
    row
  end

  def mark_board(color, column)
    row = lowest_space(column)
    @board[row][column] = color
    print_board
  end
end
