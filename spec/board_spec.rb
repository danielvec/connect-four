require_relative '../lib/board'

describe Board do
  describe '#game_board' do

    subject(:make_board) { described_class.new }

    it 'returns 6 arrays' do
      arrays = make_board.board
      amount_arrays = arrays.length
      expect(amount_arrays).to eq(6)
    end

    it 'returns arrays with a length of 7' do
      array = make_board.board[0]
      array_length = array.length
      expect(array_length).to eq(7)
    end
  end

  describe '#lowest_space' do
    subject(:board_lowest) { described_class.new }
    context 'when the board is empty' do
      it 'returns 5' do
        column = 3
        lowest_row = board_lowest.lowest_space(column)
        expect(lowest_row).to eq(5)
      end
    end

    context 'when the bottom row is full' do
      before do
        board_lowest.board[5][3] = 'o'
      end
      it 'returns 4' do
        column = 3
        lowest_row = board_lowest.lowest_space(column)
        expect(lowest_row).to eq(4)
      end
    end
  end

  describe '#mark_board' do
    subject(:board_mark) { described_class.new }

    it 'marks board' do
      color = 'white'
      column = 2
      last_row = 5
      board_mark.mark_board(color, column)
      target = board_mark.board[last_row][column]
      expect(target).to eq(color)
    end
  end
end
