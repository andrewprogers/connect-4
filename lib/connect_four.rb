require_relative "Board"
require_relative "Player"
require_relative "Piece"
require_relative "player_creator"

class ConnectFourGame

  def initialize
    player_creator = PlayerCreator.new()
    @player1 = player_creator.newPlayer
    @player2 = player_creator.newPlayer
    @board = Board.new
    game_loop
  end

  private
  def createPlayer
    name = get_player_name
    char = get_player_char
    color = @colors.pop

    Player.new(name, color, char)
  end

  def game_loop
    loop do
      play_game
      print "Would you like to play again (Y/N)? "
      input = get_yn
      break unless input.downcase == 'y'
      reset_game
    end
  end

  def play_game
    current_player = (rand(2) == 0) ? @player1 : @player2
    until @board.full? || @board.winner
      turn(current_player)
      current_player = next_player(current_player)
    end
  end

  def turn(player)
    system "clear" or system "cls"
    @board.print_board
    print "It is #{player.name}'s turn. Please select a column(1-7): "
    selection = get_column_choice
    @board.column(selection).add_piece(Piece.new(player.color, player.character))
  end

  def get_column_choice
    gets.chomp.to_i
  end

  def next_player(player)
    (player == @player2) ? @player1 : @player2
  end

  def get_yn
    loop do
      input = gets.chomp
      return input if ['y', 'n'].include?(input.downcase)
      print "Please enter Y or N: "
    end
  end

  def reset_game
    @board = Board.new
  end
end

g = ConnectFourGame.new
