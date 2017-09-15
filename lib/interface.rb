class Interface

  PLAYER_ICONS = ['X','O']

  def initialize config = {}
    config = defaults.merge config
    @human_player_class = config[:human_player]
    @com_player_class   = config[:com_player]
    @game_class         = config[:game]
    @game = game_class.new
  end

  def add_human_player
    raise NotImplementedError
  end

  def draw_board
    raise NotImplementedError
  end

  def add_com_player name = 'com'
    game.add_player com_player_class.new(name: name, icon: get_next_icon)
  end

  private
  attr_reader :human_player_class, :com_player_class, :game_class, :game

  def get_next_icon
    PLAYER_ICONS[game.players.length]
  end

  def defaults
    {
      human_player: 'bbq',
      com_player:   'cheese',
      game: 'fsadfa'
    }
  end
end
