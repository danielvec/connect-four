require_relative '../lib/player'
require_relative '../lib/board'

describe Player do
  describe '#choose_column' do

    subject(:player_choice) { described_class.new('black') }

    context 'when user number is between arguments' do
      before do
        valid_input = 4
        allow(player_choice).to receive(:gets).and_return(valid_input)
      end
  
      it 'returns without displaying puts with error message' do
        error_message = 'not a valid column'
        expect(player_choice).not_to receive(:puts).with(error_message)
        player_choice.choose_column
      end
    end
  
    context 'when user inputs an incorrect value once, then a valid input' do
      before do
        intro_message = 'Choose a column between 1 and 7'
        allow(player_choice).to receive(:puts).with(intro_message)
        invalid_input = 0
        valid_input = 1
        allow(player_choice).to receive(:gets).and_return(invalid_input, valid_input)
      end
  
      it 'returns after displaying puts with error message once' do
        error_message = 'not a valid column'
        expect(player_choice).to receive(:puts).with(error_message).once
        player_choice.choose_column
      end
    end
  end
  
  describe '#make_move' do
    let(:game_board) { instance_double(Board) }
    subject(:player_move) { described_class.new('black', game_board) }

    before do
      column = 2
      allow(player_move).to receive(:choose_column).and_return(column)
    end

    it 'sends mark_board to Board' do
      expect(game_board).to receive(:mark_board).with('black', 2).once
      player_move.make_move
    end
  end
end