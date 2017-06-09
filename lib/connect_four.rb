require_relative "Board"
require_relative "Player"
require_relative "Piece"
require_relative "player_creator"

class ConnectFourGame
  def initialize
    player_creator = PlayerCreator.new()
    @player1 = player_creator.newPlayer
    @player2 = player_creator.newPlayer
    game_loop
  end

  private
  def game_loop
    loop do
      play_game
      break unless continue?
    end
  end

  def play_game
    @board = Board.new
    current_player = (rand(2) == 0) ? @player1 : @player2
    until @board.full? || @board.winner
      turn(current_player)
      current_player = (current_player == @player2) ? @player1 : @player2
    end
    score_report
  end

  def turn(player)
    system "clear" or system "cls"
    @board.print_board
    print "It is #{player.name}'s turn. Please select a column(1-7): "
    selection = get_column_choice
    @board.column(selection).add_piece(Piece.new(player))
  end

  def get_column_choice
    loop do
      input = gets.chomp.to_i
      if !(1..7).include?(input)
        print "Please enter a number 1-7: "
      elsif @board.column(input).full?
        print "That column is full! Choose another: "
      else
        return input
      end
    end
  end

  def continue?
    loop do
      puts "Would you like to play again (Y/N)? "
      input = gets.chomp.downcase
      return true if input == 'y'
      return false if input == 'n'
      print "Please enter Y or N: "
    end
  end

  def score_report
    @board.print_board
  end
end

g = ConnectFourGame.new
