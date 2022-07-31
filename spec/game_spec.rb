require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'

describe Game do
  describe '#play_game' do
    let(:game_board) { instance_double(Board) }
    let(:first_player) { instance_double(Player) }
    let(:second_player) { instance_double(Player) }
    subject(:game_play) { described_class.new(game_board, first_player, second_player) }
    
    it 'sends print_board to board' do
      allow(first_player).to receive(:make_move)
      allow(second_player).to receive(:make_move)
      expect(game_board).to receive(:print_board).once
      game_play.play_game
    end

    it 'sends make_move to player_one' do
      allow(game_board).to receive(:print_board).once
      allow(second_player).to receive(:make_move)
      expect(first_player).to receive(:make_move)
      game_play.play_game
    end

    it 'sends make_move to player_two' do
      allow(game_board).to receive(:print_board).once
      allow(first_player).to receive(:make_move)
      expect(second_player).to receive(:make_move)
      game_play.play_game
    end

    #it 'loops through player one and two moves until game over' do

    #end
  end
  describe '#game_over?' do
    let(:game_board) { instance_double(Board) }
    subject(:game_end) { described_class.new(game_board) }

    context 'when board is full' do
      before do
        full_board = [%w[o o o o o o o], %w[o o o o o o o],
                      %w[o o o o o o o], %w[o o o o o o o],
                      %w[o o o o o o o], %w[o o o o o o o]]
        allow(game_board).to receive(:board).and_return(full_board)
      end
      it 'is game over' do
        expect(game_end).to be_game_over
      end
    end

    context 'when board is empty' do
      before do
        empty_board = [%w[_ _ _ _ _ _ _], %w[_ _ _ _ _ _ _],
                       %w[_ _ _ _ _ _ _], %w[_ _ _ _ _ _ _],
                       %w[_ _ _ _ _ _ _], %w[_ _ _ _ _ _ _]]
        allow(game_board).to receive(:board).and_return(empty_board)
      end
      it 'is not game over' do
        expect(game_end).to_not be_game_over
      end
    end

    context 'when board has one empty space' do
      before do
        one_space = [%w[o o _ o o o o], %w[o o o o o o o],
                     %w[o o o o o o o], %w[o o o o o o o],
                     %w[o o o o o o o], %w[o o o o o o o]]
        allow(game_board).to receive(:board).and_return(one_space)
      end
      it 'is not game over' do
        expect(game_end).to_not be_game_over
      end
    end
  end
  describe '#row_win?' do
    let(:game_board) { instance_double(Board) }
    subject(:win_row) { described_class.new(game_board) }

    context 'when a player has 4 consecutive marks in a row' do
      before do
        board_win = [%w[_ _ _ _ _ _ _], %w[_ _ _ _ _ _ _],
                     %w[_ _ _ _ _ _ _], %w[_ _ _ _ _ _ _],
                     %w[_ _ _ _ _ _ _], %w[_ _ \u26AA \u26AA \u26AA \u26AA _]]
        allow(game_board).to receive(:board).and_return(board_win)
      end

      it 'is row win' do
        expect(win_row).to be_row_win
      end
    end

    context 'when no player has 4 consecutive marks in a row' do
      before do
        no_win = [%w[_ _ _ _ _ _ _], %w[_ _ _ _ _ _ _],
                  %w[_ _ _ _ _ _ _], %w[_ _ _ _ _ _ _],
                  %w[_ _ _ _ _ _ _], %w[\u26AA \u26AA \u26AA \u26AB \u26AA \u26AB \u26AB]]
        allow(game_board).to receive(:board).and_return(no_win)
      end
      
      it 'is not row win' do
        expect(win_row).to_not be_row_win
      end
    end
  end

  describe '#column_win?' do
    let(:game_board) { instance_double(Board) }
    subject(:win_column) { described_class.new(game_board) }

    context 'when a player has 4 consecutive marks in a column' do
      before do
        board_win = [%w[_ _ _ _ _ _ _], %w[_ _ _ _ _ _ _],
                     %w[_ _ \u26AA _ _ _ _], %w[_ _ \u26AA _ _ _ _],
                     %w[_ _ \u26AA _ _ _ _], %w[_ _ \u26AA _ _ _ _]]
        allow(game_board).to receive(:board).and_return(board_win)
      end

      it 'is column win' do
        expect(win_column).to be_column_win
      end
    end

    context 'when no player has 4 consecutive marks in a column' do
      before do
        no_win = [%w[_ _ _ _ _ _ _], %w[_ _ _ \u26AB _ _ _],
                  %w[_ _ _ _ _ _ _], %w[_ _ _ \u26AB _ _ _],
                  %w[_ _ _ \u26AA _ _ _], %w[_ \u26AA \u26AA \u26AB \u26AB \u26AB _]]
        allow(game_board).to receive(:board).and_return(no_win)
      end
      
      it 'is not column win' do
        expect(win_column).to_not be_column_win
      end
    end
  end

  describe '#diagonal_win?' do
    let(:game_board) { instance_double(Board) }
    subject(:win_diagonal) { described_class.new(game_board) }

    context 'when a player has 4 consecutive marks in a diagonal' do
      before do
        board_win = [%w[\u26AB _ _ _ _ _ _], %w[_ \u26AB _ _ _ _ _],
                     %w[_ _ \u26AB _ _ _ _], %w[_ _ \u26AA \u26AB _ _ _],
                     %w[_ _ \u26AA _ _ _ _], %w[_ _ \u26AA _ _ _ _]]
        allow(game_board).to receive(:board).and_return(board_win)
      end

      it 'is diagonal win' do
        expect(win_diagonal).to be_diagonal_win
      end
    end

    context 'when no player has 4 consecutive marks in a diagonal' do
      before do
        no_win = [%w[_ _ _ _ _ _ _], %w[_ _ _ \u26AB _ _ _],
                  %w[_ _ _ _ _ _ _], %w[_ _ _ \u26AB _ _ _],
                  %w[_ _ _ \u26AA _ _ _], %w[_ \u26AA \u26AA \u26AB \u26AB \u26AB _]]
        allow(game_board).to receive(:board).and_return(no_win)
      end
      
      it 'is not column win' do
        expect(win_diagonal).to_not be_diagonal_win
      end
    end
  end
      
end