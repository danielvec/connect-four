require_relative 'board'

# represents a player of connect four
class Player
  attr_reader :color

  def initialize(color, board = Board.new)
    @color = color
    @board = board
  end

  def choose_column
    loop do
      puts 'Choose a column between 1 and 7'
      column = gets.to_i - 1
      return column if column >= 0 && column < 8

      puts 'not a valid column'
    end
  end

  def make_move
    column = choose_column
    if @board.lowest_space(column).negative?
      puts 'not a valid column'
      make_move
    else
      @board.mark_board(color, column)
    end
  end
end
