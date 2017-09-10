require 'board'

describe Board do
  let(:empty_board){[[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]]}
  let(:player_one_symbol){'X'}
  let(:player_one){double('player_one',symbol: player_one_symbol)}

  describe '#creation' do
    it 'starts with 9 empty squares by default' do
      expect(subject.board).to eq empty_board
    end
    it 'can be configured to have a different empty_symbol' do
      new_symbol = 'chips'
      board = Board.new(empty_symbol: new_symbol)
      expect(board.getSymbol [0,0]).to equal new_symbol
    end
    it 'can be configured to have a different sized grid' do
      size = rand(1..6)
      board = Board.new(size: size)
      expect(board.board.size).to eq size
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
      subject.addMove(player: player_one, location: [0,0])
      expect(subject.board[0][0]).to eq player_one
    end
    it 'requires a location' do
      expect {subject.addMove(player: player_one)}.to raise_error 'move location not provided'
    end
    it 'requires a player' do
      expect {subject.addMove(location: [0,0])}.to raise_error 'move player not provided'
    end
    it 'won\'t allow a location in a bad location' do
      error = 'move location out of range'
      expect{subject.addMove(player: player_one, location: [-1,0])}.to raise_error error
      expect{subject.addMove(player: player_one, location: [4 ,0])}.to raise_error error
      expect{subject.addMove(player: player_one, location: 5)}.to raise_error error
      expect{subject.addMove(player: player_one, location: 54)}.to raise_error error
      expect{subject.addMove(player: player_one, location: [54])}.to raise_error error
    end
    it 'will only allow you to move in a empty spot' do
      error = 'square not empty'
      expect(subject.addMove(player: player_one, location: [0,0])).to equal true
      expect{subject.addMove(player: player_one, location: [0,0])}.to raise_error error
    end
    it 'will only allow you to make a move if the board isn\'t won' do
      error = 'move cannot be added after game is over'
      subject.addMove(player: player_one, location: [0,0])
      subject.addMove(player: player_one, location: [0,1])
      subject.addMove(player: player_one, location: [0,2])
      expect{subject.addMove(player: player_one, location: [1,1])}.to raise_error error
    end
  end

  describe '#gameWon?' do
    it 'returns true when won' do
      subject.addMove(player: player_one, location: [0,0])
      subject.addMove(player: player_one, location: [0,1])
      subject.addMove(player: player_one, location: [0,2])
      expect(subject.gameWon?).to equal true
    end
    it 'detects horizontals' do
      subject.addMove(player: player_one, location: [0,0])
      subject.addMove(player: player_one, location: [1,0])
      subject.addMove(player: player_one, location: [2,0])
      expect(subject.gameWon?).to equal true
    end
    it 'detects top to bottom diagonals' do
      subject.addMove(player: player_one, location: [0,0])
      subject.addMove(player: player_one, location: [1,1])
      subject.addMove(player: player_one, location: [2,2])
      expect(subject.gameWon?).to equal true
    end
    it 'detects diagonals going the other way' do
      subject.addMove(player: player_one, location: [0,2])
      subject.addMove(player: player_one, location: [1,1])
      subject.addMove(player: player_one, location: [2,0])
      expect(subject.gameWon?).to equal true
    end
    it 'returns false otherwise' do
      expect(subject.gameWon?).to equal false
      subject.addMove(player: player_one, location: [0,1])
      expect(subject.gameWon?).to equal false
    end
  end

  describe 'gamestate' do
    it 'returns draw when full' do
      subject.addMove(player: player_one, location: [0,0])
      subject.addMove(player: 'player_two', location: [0,1])
      subject.addMove(player: 'player_three', location: [0,2])
      subject.addMove(player: 'player_four', location: [1,0])
      subject.addMove(player: 'player_five', location: [1,1])
      subject.addMove(player: 'player_six', location: [1,2])
      subject.addMove(player: 'player_seven', location: [2,0])
      subject.addMove(player: 'player_eight', location: [2,1])
      expect(subject.gameState).to eq 'ongoing'
      subject.addMove(player: player_one, location: [2,2])
      expect(subject.gameState).to eq 'draw'
    end
    it 'returns won when won' do
      subject.addMove(player: player_one, location: [0,0])
      subject.addMove(player: player_one, location: [0,1])
      expect(subject.gameState).to eq 'ongoing'
      subject.addMove(player: player_one, location: [0,2])
      expect(subject.gameState).to eq 'won'
    end
  end

  describe '#winner' do
    it 'returns the winner' do
      subject.addMove(player: player_one, location: [0,0])
      subject.addMove(player: player_one, location: [1,0])
      expect(subject.winner).to equal nil
      subject.addMove(player: player_one, location: [2,0])
      expect(subject.winner).to equal player_one
    end
  end


  describe '#getSymbol' do
    it 'returns the mark of whatever is at that spot in the board' do
      expect(subject.getSymbol([0,0])).to eq ''
      subject.addMove(player: player_one, location: [0,0])
      expect(subject.getSymbol([0,0])).to eq player_one_symbol
    end
    it 'checks range before allowing retrieval' do
      error = 'Symbol location out of range'
      expect{subject.getSymbol([-1,0])}.to raise_error error
    end
  end
end
