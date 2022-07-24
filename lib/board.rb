class Board
  def game_board
    [%w[_ _ _ _ _ _ _], %w[_ _ _ _ _ _ _],
     %w[_ _ _ _ _ _ _], %w[_ _ _ _ _ _ _],
     %w[_ _ _ _ _ _ _], %w[_ _ _ _ _ _ _]]  
  end

  def print_board
    game_board.each do |row|
      p row
    end
  end
end

b = Board.new
b.print_board