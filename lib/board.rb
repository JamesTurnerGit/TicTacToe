class Board

  def initialize (empty_symbol: "", size: 9)
    @size = size - 1
    @empty_symbol = empty_symbol
    @board = [nil] * size
  end

  def board
    @board.clone
  end

  def addMove player: nil, location: nil
    raise 'move player not provided' if player == nil
    raise 'move location not provided' if location == nil
    raise 'move location out of range' if locationInRange? location
    return false if board[location]
    @board[location] = player
    true
  end

  def getMark location
    raise 'mark location out of range' if locationInRange? location
    return empty_symbol if board[location] == nil
    board[location].symbol
  end

  private

  attr_reader :empty_symbol, :size

  def locationInRange? location
    location > size || location < 0
  end
end
