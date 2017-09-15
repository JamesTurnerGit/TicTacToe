require 'interface'

describe Interface do
  let(:human_player_class) { double 'human_player_class', new: human_player }
  let(:human_player)       { double 'human_player' }
  let(:com_player_class) { double 'com_player_class', new: com_player }
  let(:com_player)       { double 'com_player' }
  let(:game_class) { double 'game_class', new: game }
  let(:game)       { double 'game', add_player: nil, players: []}

  let(:config)  { { human_player: human_player_class,
                    com_player: com_player_class,
                    game: game_class } }
  let(:subject) { Interface.new(config) }

  describe '#creation'

  describe '#add_human_player' do
    it 'raises not implemented error' do
      expect { subject.add_human_player }.to raise_error NotImplementedError
    end
  end

  describe '#add_com_player' do
    it 'makes a new com player' do
      subject.add_com_player('bob')
      expect(com_player_class).to have_received(:new).with(name: 'bob',icon: 'X')
    end

    it 'gives player two a different icon' do
      allow(game).to receive(:players).and_return(['bob'])
      subject.add_com_player('ross')
      expect(com_player_class).to have_received(:new).with(name: 'ross',icon: 'O')
    end
  end
  describe '#start_game'
  describe '#setup_game'
  describe '#get_players'
end
