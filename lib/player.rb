class PlayerCreationError < ArgumentError
end

class Player
  attr_reader :name, :color, :character

  def initialize(name, color, character)
    @name = name
    @color = color
    @character = validateCharacter(character)
  end

  private
  def validateCharacter(char)
    raise PlayerCreationError unless char.length == 1
    char
  end
end
