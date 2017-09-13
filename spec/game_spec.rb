require 'game'
describe Game do
  let(:player_1)      {double 'player_1', get_move: player_1_move}
  let(:player_1_move) {double 'player 1\'s move'}
  let(:player_2)      {double 'player_2'}

  let(:board_class)   {double 'board_class', new: board}
  let(:board)         {double 'board', add_move: nil}
  let(:subject) do
    Game.new(board_class:   board_class)
  end

  describe '#creation' do
  end
  context 'no game in progress' do
    describe '#players' do
      it 'starts as an empty array' do
        expect(subject.players.is_a?(Array))
        expect(subject.players.length).to eq 0
      end
    end

    describe '#add_player' do
      it 'adds a player to playerlist' do
        subject.add_player(player_1)
        expect(subject.players[0]).to equal player_1
      end
      it 'adds players in order' do
        subject.add_player(player_1)
        subject.add_player(player_2)
        expect(subject.players[1]).to equal player_2
      end
    end
    context 'trying to call methods that require game to be started' do
      let(:error_message) { 'game not in progress' }
      it '#take_move' do
        expect{ subject.take_move }.to raise_error error_message
      end
    end

    describe '#new_game' do
      it 'requires at least two players' do
        error_message = 'not enough players'
        expect { subject.new_game }.to raise_error error_message
        subject.add_player(player_1)
        expect { subject.new_game }.to raise_error error_message
        subject.add_player(player_2)
        expect { subject.new_game }.not_to raise_error
      end
    end
  end

  context 'game in progress' do
    before(:each) do
      subject.add_player(player_1)
      subject.add_player(player_2)
      subject.new_game
    end

    describe '#take_move' do
      it 'calls get_move on current-player' do
        subject.take_move
        expect(player_1).to have_received(:get_move)
      end
      it 'passes current-player move to board' do
        subject.take_move
        expect(board).to have_received(:add_move).with (player_1_move)
      end
    end

    describe '#turn_order' do
      it 'starts player1, player2' do
        expect(subject.turn_order).to eq [player_1, player_2]
      end
      it 'changes to player2_player1 after a move' do
        subject.take_move
        expect(subject.turn_order).to eq [player_2, player_1]
      end
    end

  end
end
