require 'board'
require 'console_output'

class Game
  attr_reader :players, :game_in_progress

  @game_in_progress = false
  @turn_order_array

  def initialize (board_class: Board)
    @players = []
  end

  def add_player(player)
    @players << player
  end

  def new_game(size = 3)
    raise 'not enough players' if players.length < 2
    @game_in_progress = true
    @turn_order_array = players
  end

  def turn_order
    raise_if_game_not_in_progress
    turn_order_array
  end

  def current_player
    turn_order.first
  end

  def take_move
    raise_if_game_not_in_progress
    turn_order.rotate!
  end

  private
  attr_reader :turn_order_array

  def raise_if_game_not_in_progress
    raise 'game not in progress' if !game_in_progress
  end
end
