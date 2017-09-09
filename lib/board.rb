class Board

  def initialize (empty_symbol: "", size: 3)
    @size = size - 1
    @empty_symbol = empty_symbol
    @board = []
    size.times do
      @board << [nil] * size
    end
  end

  def board
    @board.clone
  end

  def addMove player: nil, location: nil
    raise 'move player not provided' if player == nil
    raise 'move location not provided' if location == nil
    raise 'move location out of range' unless validLocation? location
    return false if board[location[0]][location[1]]
    @board [location[0]][location[1]] = player
    true
  end

  def getMark location
    raise 'mark location out of range' unless validLocation? location
    return empty_symbol if board[location[0]][location[1]] == nil
    board[location[0]][location[1]].symbol
  end

  private

  attr_reader :empty_symbol, :size

  def validLocation? location
    return false unless (location.is_a? Array) && (location.length == 2)
    location_x_valid = location[0] < size && location[0] >= 0
    location_y_valid = location[1] < size && location[1] >= 0
    location_x_valid && location_y_valid
  end
end
