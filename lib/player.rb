class Player
  attr_reader :name, :symbol

  def initialize (name: nil, symbol: nil)
    raise "player not provided with a name" if name == nil
    raise "player not provided with a symbol" if symbol == nil
    @name = name
    @symbol = symbol
  end

  def takeMove
    raise "please implement in a child class"
  end
  
end
