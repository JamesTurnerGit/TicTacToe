require 'board'

describe Board do
  let(:empty_board){['0','1','2','3','4','5','6','7','8']}
  let(:player_one){double('player_one')}

  describe '#creation' do
    it 'starts with 9 empty squares' do
      expect(subject.board).to eq empty_board
    end
  end

  describe '#board' do
    it 'returns an array that doesn\'t change the original' do
      board = subject.board
      board[0] = 'sausages'
      expect(subject.board).to eq empty_board
    end
  end

  describe '#addMove' do
    it 'stores a reference to the player in a slot' do
      subject.addMove(player: player_one, location: 0)
      expect(subject.board[0]).to eq player_one
    end

    it 'requires a location' do
      expect {subject.addMove(player: player_one)}.to raise_error 'location not provided'
    end

    it 'requires a player' do
      expect {subject.addMove(location: 0)}.to raise_error 'player not provided'
    end
    it 'won\'t allow a location above 8 or below 0' do
      error = 'location out of range'
      expect{subject.addMove(player: player_one, location: -1)}.to raise_error error
      expect{subject.addMove(player: player_one, location: 9)}.to raise_error error
    end
  end
end
