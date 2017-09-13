require 'player'

describe Player do
  let(:player_name) { double('player_name') }
  let(:player_icon) { double('player_icon') }

  let(:subject) { Player.new(name: player_name, icon: player_icon) }

  describe '#creation' do
    it 'creates if given a name and a icon' do
      player_config = { name: player_name, icon: player_icon }
      expect { Player.new(player_config) }.not_to raise_error
    end
    it 'requires a name' do
      error_message = 'player not provided with a name'
      expect { Player.new(icon: player_icon) }.to raise_error error_message
    end
    it 'requires a icon' do
      error_message = 'player not provided with a icon'
      expect { Player.new(name: player_name) }.to raise_error error_message
    end
  end

  describe '#name' do
    it 'returns it\'s name' do
      expect(subject.name).to equal player_name
    end
  end

  describe '#icon' do
    it 'returns it\'s icon' do
      expect(subject.icon).to equal player_icon
    end
  end

  describe '#takeMove' do
    it 'raises not implemented' do
      error_message = 'please implement in a child class'
      expect { subject.take_move }.to raise_error NotImplementedError
    end
  end
end
