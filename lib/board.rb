class Board
  attr_reader :size, :winner

  def initialize (empty_symbol: "", size: 3)
    @size = size - 1
    @empty_symbol = empty_symbol
    @board = []
    size.times do
      @board <<  [nil] * size
    end
  end

  def board
    @board.clone
  end

  def addMove player: nil, location: nil
    raise 'move player not provided' if player == nil
    raise 'move location not provided' if location == nil
    raise 'move location out of range' unless validLocation? location
    raise 'move cannot be added after game is over' if gameWon? || full?
    raise 'square not empty' if board[location[0]][location[1]]
    @board [location[0]][location[1]] = player
    @winner = player if gameWon?
    true
  end

  def getMark location
    raise 'mark location out of range' unless validLocation? location
    return empty_symbol if board[location[0]][location[1]] == nil
    board[location[0]][location[1]].symbol
  end

  def gameWon?
    horizontalsWon? || verticalsWon? || diagonalsWon?
  end

  def gameState
    return "won" if gameWon? 
    return "draw" if full?
    "ongoing"
  end

  private

  attr_reader :empty_symbol

  def verticalsWon?
    linesWon? board
  end

  def horizontalsWon?
    linesWon? board.transpose
  end

  def diagonalsWon?
    top_to_bottom_diagonal = findTopToBottomDiagonal board
    bottom_to_top_diagonal = findTopToBottomDiagonal board.transpose.reverse
    linesWon? [top_to_bottom_diagonal,bottom_to_top_diagonal]
  end

  def full?
    board.flatten.compact.length == (size + 1) * (size + 1)
  end

  def findTopToBottomDiagonal board
    result = []
    board.each_with_index do |line,index|
      result << line[index]
    end
    result
  end

  def linesWon? lines
    lines.each do |line|
      return true if lineWon? line
    end
    return false
  end

  def lineWon? line
    line.compact.length == size + 1 && line.uniq.length == 1
  end

  def validLocation? location
    return false unless (location.is_a? Array) && (location.length == 2)
    location_x_valid = location[0] <= size && location[0] >= 0
    location_y_valid = location[1] <= size && location[1] >= 0
    location_x_valid && location_y_valid
  end
end
