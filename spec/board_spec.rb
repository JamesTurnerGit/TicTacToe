require 'board'

describe Board do
  let(:empty_board){['0','1','2','3','4','5','6','7','8']}
  describe '#creation' do
    it 'starts with 9 empty squares' do
      expect(subject.board).to eq empty_board
    end
  end

  describe '#board' do
    it 'returns an array that doesn\'t change the original' do
      board = subject.board
      board[0] = "sausages"
      expect(subject.board).to eq empty_board
    end
  end
end
