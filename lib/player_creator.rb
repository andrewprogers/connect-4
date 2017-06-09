require_relative "player"

class PlayerCreator
  def initialize()
    @players = []
    @colors = ["red", "yellow"].shuffle!
  end

  def newPlayer
    name = get_player_name
    char = get_player_char
    color = @colors.pop
    @players << Player.new(name, color, char)
    @players[-1]
  end

  private
  def get_player_name
    loop do
      print "Enter a name for player #{(@players.length + 1).to_s}: "
      input = gets.chomp
      return input unless @players.any? { |player| input == player.name}
      puts "That name is already taken!!!"
    end
  end

  def get_player_char
    loop do
      print "Enter a single character for player #{(@players.length + 1).to_s}: "
      input = gets.chomp
      unless input.length == 1
        puts "One character only!"
        next
      end
      return input unless @players.any? { |player| input == player.character}
      puts "That character is already taken!!!"
    end
  end
end
