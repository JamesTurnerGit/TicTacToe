class Board
  def initialize
    @board = ["0","1","2","3","4","5","6","7","8"]
  end

  def board
    @board.clone
  end

  def addMove player: nil, location: nil
    raise "player not provided" if player == nil
    raise "location not provided" if location == nil
    raise "location out of range" if location > 8 || location < 0
    @board[location] = player
  end

end
