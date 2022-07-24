require_relative '../lib/board'

describe Board do
  describe '#game_board' do

    subject(:make_board) { described_class.new }

    it 'returns 6 arrays' do
      arrays = make_board.game_board
      amount_arrays = arrays.length
      expect(amount_arrays).to eq(6)
    end

    it 'returns arrays with a length of 7' do
      array = make_board.game_board[0]
      array_length = array.length
      expect(array_length).to eq(7)
    end
  end


end