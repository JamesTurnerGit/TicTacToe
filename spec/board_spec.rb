require 'board'

describe Board do
  let(:empty_board){[nil,nil,nil,nil,nil,nil,nil,nil,nil]}
  let(:player_one_symbol){"X"}
  let(:player_one){double('player_one',symbol: player_one_symbol)}

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
      expect {subject.addMove(player: player_one)}.to raise_error 'move location not provided'
    end

    it 'requires a player' do
      expect {subject.addMove(location: 0)}.to raise_error 'move player not provided'
    end

    it 'won\'t allow a location above 8 or below 0' do
      error = 'move location out of range'
      expect{subject.addMove(player: player_one, location: -1)}.to raise_error error
      expect{subject.addMove(player: player_one, location: 9)}.to raise_error error
    end

    it 'will only allow you to move in a empty spot' do
      expect(subject.addMove(player: player_one, location: 0)).to equal true
      expect(subject.addMove(player: player_one, location: 0)).to equal false
    end

    xit 'will only allow you to make a move if the board isn\'t won'
  end

  describe '#winner' do
    it "returns the winner"
  end

  describe '#gameOver?' do
    it "returns the gamestate"
  end

  describe '#getmark' do
    it "returns the mark of whatever is at that spot in the board" do
      subject.addMove(player: player_one, location: 0)
      expect(subject.getMark(0)).to eq player_one_symbol
      expect(subject.getMark(1)).to eq ""
    end
    
    it "checks range before allowing retrieval" do
      error = 'mark location out of range'
      expect{subject.getMark(-1)}.to raise_error error
      expect{subject.getMark(9)}.to raise_error error
    end
  end
end
