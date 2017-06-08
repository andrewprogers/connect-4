class PieceCreationError < ArgumentError
end

class Piece
  VALID_COLORS = ['red', 'yellow']
  COLOR_CODES = {
    'red' => 31,
    'yellow' => 33
  }

  attr_reader :color

  def initialize(color, character)
    @color = validateColor(color)
    @character = validateCharacter(character)
  end

  def to_s
    "\e[#{color_code}m" + @character + "\e[0m"
  end

  private
    def color_code
      COLOR_CODES[@color]
    end

    def validateColor(color)
      color = color.downcase
      raise PieceCreationError unless VALID_COLORS.include?(color)
      color
    end

    def validateCharacter(char)
      raise PieceCreationError unless char.length == 1
      char
    end
end
