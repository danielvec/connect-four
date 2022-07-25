require_relative 'board'

class Player
  attr_reader :color

  def initialize(color, board = Board.new)
    @color = color
    @board = board
  end

  def choose_column
    puts 'Choose a column between 1 and 7'
    column = gets.to_i - 1
    return if column > 0 && column < 8

    puts 'not a valid column'
  end

  def make_move
    column = choose_column
    @board.mark_board(color, column)
  end
end