require 'board'
require 'console_output'

class Game
  attr_reader :players, :game_in_progress, :turn_order, :board

  @game_in_progress = false

  def initialize (board_class: Board)
    @players = []
    @board_class = board_class
  end

  def add_player(player)
    @players << player
  end

  def new_game(size = 3)
    raise 'not enough players' if players.length < 2
    @board = board_class.new
    @game_in_progress = true
    @turn_order = players
  end

  def current_player
    turn_order.first
  end

  def take_move
    raise_if_game_not_in_progress
    board.add_move(current_player.get_move)
    @turn_order.rotate!
  end

  private
  attr_reader :board_class

  def raise_if_game_not_in_progress
    raise 'game not in progress' if !game_in_progress
  end
end
