require 'player'

describe Player do
  let(:player_name){double('player_name')}
  let(:player_symbol){double('player_symbol')}

  let(:subject){ Player.new(name: player_name, symbol: player_symbol)}

  describe '#creation' do

    it 'creates if given a name and a symbol' do
      expect {Player.new(name: player_name, symbol: player_symbol)}.not_to raise_error
    end
    it 'requires a name' do
      expect {Player.new(symbol: player_symbol)}.to raise_error 'player not provided with a name'
    end
    it 'requires a symbol' do
      expect {Player.new(name: player_name)}.to raise_error 'player not provided with a symbol'
    end
  end

  describe '#name' do
    it 'returns it\'s name' do
      expect(subject.name).to equal player_name
    end
  end

  describe '#symbol' do
    it 'returns it\'s symbol' do
      expect(subject.symbol).to equal player_symbol
    end
  end

  describe '#takeMove' do
    it 'raises not implemented' do
      expect{subject.takeMove}.to raise_error 'please implement in a child class'
    end
  end
end
