
class Piece
  COLOR_CODES = {
    'red' => 31,
    'yellow' => 33
  }

  attr_reader :color, :player

  def initialize(player)
    @player = player
    @color = player.color
    @character = player.character
  end

  def to_s
    "\e[#{color_code}m" + @character + "\e[0m"
  end

  private
    def color_code
      COLOR_CODES[@color]
    end
end
