require_relative 'board'
require_relative 'player'

# represents a game of connect four
class Game
  def initialize(board = Board.new, player_one = Player.new("\u26AA", board), player_two = Player.new("\u26AB", board))
    @board = board
    @player_one = player_one
    @player_two = player_two
  end

  def play_game
    @board.print_board
    player_one_turn
  end

  def player_one_turn
    @player_one.make_move
    if game_over?
      puts 'Player one wins!'
    else
      player_two_turn
    end
  end

  def player_two_turn
    @player_two.make_move
    if game_over?
      puts 'Player two wins' unless game_tie?
      puts 'tie' if game_tie?
    else
      player_one_turn
    end
  end

  def game_over?
    game_tie? || row_win? || column_win? || diagonal_win?
  end

  def game_tie?
    !@board.board.flatten.include?('_')
  end

  def row_win?(board = @board.board)
    win = false
    (0...board.length).each do |i|
      if board[i].chunk { |mark| mark == "\u26AA" }.any? {|mark, array| mark == true && array.length > 3} ||
         board[i].chunk { |mark| mark == "\u26AB" }.any? {|mark, array| mark == true && array.length > 3}
        win = true
      end
    end
    win == true
  end

  def column_win?
    row_win?(@board.board.transpose)
  end

  def diagonal_win?(board = @board.board)
    win = false
    rows = board.length
    columns = board.transpose.length
    (0...(rows - 3)).each do |j|
      (0...(columns - 3)).each do |i|
        diagonal = []
        diagonal << board[j][i] << board[j + 1][i + 1] << board[j + 2][i + 2] << board[j + 3][i + 3]
        win = true if diagonal.all?("\u26AA") || diagonal.all?("\u26AB")
      end
      ((columns - 4)...columns).each do |i|
        diagonal = []
        diagonal << board[j][i] << board[j + 1][i - 1] << board[j + 2][i - 2] << board[j + 3][i - 3]
        win = true if diagonal.all?("\u26AA") || diagonal.all?("\u26AB")
      end
    end
    win == true
  end
end
