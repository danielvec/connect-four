require_relative 'board'
require_relative 'player'

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
      puts "Player one wins!"
    else
      player_two_turn
    end
  end

  def player_two_turn
    @player_two.make_move
    if game_over?
      puts "Player two wins" unless game_tie?
      if game_tie? 
        puts "tie"
      end
    else
      player_one_turn
    end
  end

  def game_over?
    game_tie? || row_win? || column_win? || diagonal_win?
  end

  def game_tie?
    !@board.board.flatten.include?("_")
  end

  def row_win?(board = @board.board)
    win = false
    for i in 0...board.length
      if board[i].chunk { |mark| mark == "\u26AA"}.any? {|mark, array| mark == true && array.length > 3} ||
         board[i].chunk { |mark| mark == "\u26AB"}.any? {|mark, array| mark == true && array.length > 3}
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
    for j in 0...(board.length - 3)
      for i in 0...(board.transpose.length - 3)
        diagonal = []
        diagonal << board[j][i] << board[j + 1][i + 1] << board[j + 2][i + 2] << board[j + 3][i + 3]
        if diagonal.all?("\u26AA") || diagonal.all?("\u26AB")
          win = true
        end
      end
      for i in (board.length - 3)...(board.transpose.length)
        diagonal = []
        diagonal << board[j][i] << board[j + 1][i - 1] << board[j + 2][i - 2] << board[j + 3][i - 3]
        if diagonal.all?("\u26AA") || diagonal.all?("\u26AB")
          win = true
          p 'win'
        end
      end
    end
    win == true
  end
end

N = Game.new
N.play_game