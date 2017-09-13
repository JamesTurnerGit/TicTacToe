class Player
  attr_reader :name, :icon

  def initialize(name: nil, icon: nil)
    raise 'player not provided with a name' if name.nil?
    raise 'player not provided with a icon' if icon.nil?
    @name = name
    @icon = icon
  end

  def take_move
    raise NotImplementedError
  end
end
