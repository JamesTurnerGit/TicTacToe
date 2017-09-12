class Board
  attr_reader :size, :winner

  def initialize(empty_icon: '', size: 3)
    @size = size - 1
    @empty_icon = empty_icon
    @board = []
    size.times do
      @board << [nil] * size
    end
  end

  def board
    @board.clone
  end

  def add_move(player: nil, location: nil)
    raise 'move player not provided' if player.nil?
    raise 'move location not provided' if location.nil?
    raise 'move location out of range' unless valid_location? location
    raise 'move cannot be added after game is over' if game_won? || full?
    raise 'square not empty' if board[location[0]][location[1]]
    @board [location[0]][location[1]] = player
    @winner = player if game_won?
    true
  end

  def get_icon(location)
    raise 'icon location out of range' unless valid_location? location
    return empty_icon if board[location[0]][location[1]].nil?
    board[location[0]][location[1]].icon
  end

  def game_won?
    horizontals_won? || verticals_won? || diagonals_won?
  end

  def game_state
    return 'won' if game_won?
    return 'draw' if full?
    'ongoing'
  end

  private

  attr_reader :empty_icon

  def verticals_won?
    lines_won? board
  end

  def horizontals_won?
    lines_won? board.transpose
  end

  def diagonals_won?
    top_to_bottom_diagonal = get_bottom_to_top_diagonal board
    bottom_to_top_diagonal = get_bottom_to_top_diagonal board.transpose.reverse
    lines_won? [top_to_bottom_diagonal, bottom_to_top_diagonal]
  end

  def full?
    board.flatten.compact.length == (size + 1) * (size + 1)
  end

  def get_bottom_to_top_diagonal(board)
    result = []
    board.each_with_index do |line, index|
      result << line[index]
    end
    result
  end

  def lines_won?(lines)
    lines.each do |line|
      return true if line_won? line
    end
    false
  end

  def line_won?(line)
    line.compact.length == size + 1 && line.uniq.length == 1
  end

  def valid_location?(location)
    return false unless (location.is_a? Array) && (location.length == 2)
    location_x_valid = location[0] <= size && location[0] >= 0
    location_y_valid = location[1] <= size && location[1] >= 0
    location_x_valid && location_y_valid
  end
end
