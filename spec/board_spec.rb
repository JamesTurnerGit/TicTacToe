require 'board'

describe Board do
  let(:empty_board)   { [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]] }
  let(:player_1_icon) { 'X' }
  let(:player_1)      { double('player_1', icon: player_1_icon) }

  describe '#creation' do
    it 'starts with 9 empty squares by default' do
      expect(subject.board).to eq empty_board
    end
    it 'can be configured to have a different empty_icon' do
      new_icon = 'chips'
      board = Board.new(empty_icon: new_icon)
      expect(board.get_icon([0, 0])).to equal new_icon
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

  describe '#add_move' do
    it 'stores a reference to the player in a slot' do
      subject.add_move(player: player_1, location: [0, 0])
      expect(subject.board[0][0]).to eq player_1
    end
    it 'requires a location' do
      error_message = 'move location not provided'
      expect { subject.add_move(player: player_1) }.to raise_error error_message
    end
    it 'requires a player' do
      error_message = 'move player not provided'
      expect { subject.add_move(location: [0, 0]) }.to raise_error error_message
    end
    it 'won\'t allow a location in a bad location' do
      error_message = 'move location out of range'
      expect { subject.add_move(player: player_1, location: [-1, 0]) }.to raise_error error_message
      expect { subject.add_move(player: player_1, location: [4 , 0]) }.to raise_error error_message
      expect { subject.add_move(player: player_1, location: 5)       }.to raise_error error_message
      expect { subject.add_move(player: player_1, location: 54)      }.to raise_error error_message
      expect { subject.add_move(player: player_1, location: [54])    }.to raise_error error_message
    end
    it 'will only allow you to move in a empty spot' do
      expect(subject.add_move(player: player_1, location: [0, 0])).to equal true
      expect do
        subject.add_move(player: player_1, location: [0, 0])
      end.to raise_error 'square not empty'
    end
    it 'will only allow you to make a move if the board isn\'t won' do
      subject.add_move(player: player_1, location: [0, 0])
      subject.add_move(player: player_1, location: [0, 1])
      subject.add_move(player: player_1, location: [0, 2])
      expect do
        subject.add_move(player: player_1, location: [1, 1])
      end.to raise_error 'move cannot be added after game is over'
    end
  end

  describe '#game_won?' do
    it 'returns true when won' do
      subject.add_move(player: player_1, location: [0, 0])
      subject.add_move(player: player_1, location: [0, 1])
      subject.add_move(player: player_1, location: [0, 2])
      expect(subject.game_won?).to equal true
    end
    it 'detects horizontals' do
      subject.add_move(player: player_1, location: [0, 0])
      subject.add_move(player: player_1, location: [1, 0])
      subject.add_move(player: player_1, location: [2, 0])
      expect(subject.game_won?).to equal true
    end
    it 'detects top to bottom diagonals' do
      subject.add_move(player: player_1, location: [0, 0])
      subject.add_move(player: player_1, location: [1, 1])
      subject.add_move(player: player_1, location: [2, 2])
      expect(subject.game_won?).to equal true
    end
    it 'detects diagonals going the other way' do
      subject.add_move(player: player_1, location: [0, 2])
      subject.add_move(player: player_1, location: [1, 1])
      subject.add_move(player: player_1, location: [2, 0])
      expect(subject.game_won?).to equal true
    end
    it 'returns false otherwise' do
      expect(subject.game_won?).to equal false
      subject.add_move(player: player_1, location: [0, 1])
      expect(subject.game_won?).to equal false
    end
  end

  describe 'game_state' do
    it 'returns draw when full' do
      subject.add_move(player: player_1,   location: [0, 0])
      subject.add_move(player: 'player_2', location: [0, 1])
      subject.add_move(player: 'player_3', location: [0, 2])
      subject.add_move(player: 'player_4', location: [1, 0])
      subject.add_move(player: 'player_5', location: [1, 1])
      subject.add_move(player: 'player_6', location: [1, 2])
      subject.add_move(player: 'player_7', location: [2, 0])
      subject.add_move(player: 'player_8', location: [2, 1])
      expect(subject.game_state).to eq 'ongoing'
      subject.add_move(player: player_1, location: [2, 2])
      expect(subject.game_state).to eq 'draw'
    end
    it 'returns won when won' do
      subject.add_move(player: player_1, location: [0, 0])
      subject.add_move(player: player_1, location: [0, 1])
      expect(subject.game_state).to eq 'ongoing'
      subject.add_move(player: player_1, location: [0, 2])
      expect(subject.game_state).to eq 'won'
    end
  end

  describe '#winner' do
    it 'returns the winner' do
      subject.add_move(player: player_1, location: [0, 0])
      subject.add_move(player: player_1, location: [1, 0])
      expect(subject.winner).to equal nil
      subject.add_move(player: player_1, location: [2, 0])
      expect(subject.winner).to equal player_1
    end
  end


  describe '#get_icon' do
    it 'returns the mark of whatever is at that spot in the board' do
      expect(subject.get_icon([0, 0])).to eq ''
      subject.add_move(player: player_1, location: [0, 0])
      expect(subject.get_icon([0, 0])).to eq player_1_icon
    end
    it 'checks range before allowing retrieval' do
      error_message = 'icon location out of range'
      expect { subject.get_icon([-1, 0]) }.to raise_error error_message
    end
  end
end
