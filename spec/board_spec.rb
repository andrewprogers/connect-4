require_relative "../lib/board"

describe "Board" do
  let(:yellow) do
    bob = Player.new("Bob", "yellow", "@")
    Piece.new(bob)
  end
  let(:red) do
    tim = Player.new("Tim", "red", "X")
    Piece.new(tim)
  end
  let(:empty_board) { Board.new() }
  let(:mixed_board) {
    b = Board.new()
    3.times { b.column(1).add_piece(red) }
    2.times do
      b.column(3).add_piece(red)
      b.column(3).add_piece(yellow)
    end
    b
  }
  let(:full_board) {
    b = Board.new()
    (1..7).each do |col|
      (1..6).each do |row|
        piece = ((col + row) % 2 == 0 ? red : yellow)
        b.column(col).add_piece(piece)
      end
    end
    b
  }

  describe "#initialize" do
    it "creates a new Board object" do
      expect(empty_board).to be_instance_of(Board)
    end
    it "has a reader for columns" do
      expect(empty_board.columns).to be_instance_of(Array)
    end
    it "has 7 columns" do
      expect(empty_board.columns.length).to eq(7)
    end
  end

  describe "#column" do
    it "returns a column object if n is 1 through 7" do
      expect(empty_board.column(1)).to be_instance_of(Column)
      expect(empty_board.column(7)).to be_instance_of(Column)
      expect(empty_board.column(4)).to be_instance_of(Column)
    end

    it "returns nil if number passed is not 1-7" do
      expect(empty_board.column(0)).to be_nil
      expect(empty_board.column(8)).to be_nil
    end

    it "returns the nth column when given n" do
      expect(mixed_board.column(1)).to be(mixed_board.columns[0])
    end
  end

  describe "#full?" do
    it "returns false for a board with non-full columns" do
      expect(empty_board.full?).to eq(false)
      expect(mixed_board.full?).to eq(false)
    end
    it "returns true for a full board" do
      expect(full_board.full?).to eq(true)
    end
  end

  describe "#print_board" do
    it "prints an empty board for a board with no pieces" do
      empty_board_output = <<~EOS
        ┏━━━┯━━━┯━━━┯━━━┯━━━┯━━━┯━━━┓
        ┃   │   │   │   │   │   │   ┃
        ┠───┼───┼───┼───┼───┼───┼───┃
        ┃   │   │   │   │   │   │   ┃
        ┠───┼───┼───┼───┼───┼───┼───┃
        ┃   │   │   │   │   │   │   ┃
        ┠───┼───┼───┼───┼───┼───┼───┃
        ┃   │   │   │   │   │   │   ┃
        ┠───┼───┼───┼───┼───┼───┼───┃
        ┃   │   │   │   │   │   │   ┃
        ┠───┼───┼───┼───┼───┼───┼───┃
        ┃   │   │   │   │   │   │   ┃
        ╋━━━┷━━━┷━━━┷━━━┷━━━┷━━━┷━━━╋
        ┃                           ┃
        ┻                           ┻
      EOS
      expect { empty_board.print_board }.to output(empty_board_output).to_stdout
    end
    it "prints a full board when the board is full of pieces" do
      full_board_output = <<~EOS
        ┏━━━┯━━━┯━━━┯━━━┯━━━┯━━━┯━━━┓
        ┃ \e[33m@\e[0m │ \e[31mX\e[0m │ \e[33m@\e[0m │ \e[31mX\e[0m │ \e[33m@\e[0m │ \e[31mX\e[0m │ \e[33m@\e[0m ┃
        ┠───┼───┼───┼───┼───┼───┼───┃
        ┃ \e[31mX\e[0m │ \e[33m@\e[0m │ \e[31mX\e[0m │ \e[33m@\e[0m │ \e[31mX\e[0m │ \e[33m@\e[0m │ \e[31mX\e[0m ┃
        ┠───┼───┼───┼───┼───┼───┼───┃
        ┃ \e[33m@\e[0m │ \e[31mX\e[0m │ \e[33m@\e[0m │ \e[31mX\e[0m │ \e[33m@\e[0m │ \e[31mX\e[0m │ \e[33m@\e[0m ┃
        ┠───┼───┼───┼───┼───┼───┼───┃
        ┃ \e[31mX\e[0m │ \e[33m@\e[0m │ \e[31mX\e[0m │ \e[33m@\e[0m │ \e[31mX\e[0m │ \e[33m@\e[0m │ \e[31mX\e[0m ┃
        ┠───┼───┼───┼───┼───┼───┼───┃
        ┃ \e[33m@\e[0m │ \e[31mX\e[0m │ \e[33m@\e[0m │ \e[31mX\e[0m │ \e[33m@\e[0m │ \e[31mX\e[0m │ \e[33m@\e[0m ┃
        ┠───┼───┼───┼───┼───┼───┼───┃
        ┃ \e[31mX\e[0m │ \e[33m@\e[0m │ \e[31mX\e[0m │ \e[33m@\e[0m │ \e[31mX\e[0m │ \e[33m@\e[0m │ \e[31mX\e[0m ┃
        ╋━━━┷━━━┷━━━┷━━━┷━━━┷━━━┷━━━╋
        ┃                           ┃
        ┻                           ┻
      EOS
      expect { full_board.print_board }.to output(full_board_output).to_stdout
    end
    it "prints a board with both filled and empty spaces"  do
      mixed_board_output = <<~EOS
        ┏━━━┯━━━┯━━━┯━━━┯━━━┯━━━┯━━━┓
        ┃   │   │   │   │   │   │   ┃
        ┠───┼───┼───┼───┼───┼───┼───┃
        ┃   │   │   │   │   │   │   ┃
        ┠───┼───┼───┼───┼───┼───┼───┃
        ┃   │   │ \e[33m@\e[0m │   │   │   │   ┃
        ┠───┼───┼───┼───┼───┼───┼───┃
        ┃ \e[31mX\e[0m │   │ \e[31mX\e[0m │   │   │   │   ┃
        ┠───┼───┼───┼───┼───┼───┼───┃
        ┃ \e[31mX\e[0m │   │ \e[33m@\e[0m │   │   │   │   ┃
        ┠───┼───┼───┼───┼───┼───┼───┃
        ┃ \e[31mX\e[0m │   │ \e[31mX\e[0m │   │   │   │   ┃
        ╋━━━┷━━━┷━━━┷━━━┷━━━┷━━━┷━━━╋
        ┃                           ┃
        ┻                           ┻
      EOS
      expect { mixed_board.print_board }.to output(mixed_board_output).to_stdout
    end
  end

  describe "#winner" do
    context "when there is a winning player" do
      it "it returns winner color if there is a horizontal winner" do
        h_win_one = Board.new()
        4.times { |idx| h_win_one.column(idx + 2).add_piece(red) }

        h_win_two = Board.new()
        3.times { |idx| h_win_two.column(idx + 2).add_piece(red) }
        3.times { |idx| h_win_two.column(idx + 2).add_piece(yellow) }
        2.times { h_win_two.column(5).add_piece(yellow)}

        expect(h_win_one.winner).to eq("red")
        expect(h_win_two.winner).to eq("yellow")
      end

      it "it returns winner color if there is a vertical winner" do
        v_win_one = Board.new()
        4.times { v_win_one.column(1).add_piece(red) }

        v_win_two = Board.new()
        2.times { v_win_two.column(3).add_piece(red) }
        4.times { v_win_two.column(3).add_piece(yellow) }

        v_win_three = Board.new()
        1.times { v_win_three.column(7).add_piece(red) }
        4.times { v_win_three.column(7).add_piece(yellow) }

        expect(v_win_one.winner).to eq("red")
        expect(v_win_two.winner).to eq("yellow")
        expect(v_win_three.winner).to eq("yellow")
      end

      it "it returns winner color if there is a diagonal up winner" do
        diagonal_up_winner_one = Board.new()
        3.times { |idx| diagonal_up_winner_one.column(idx + 2).add_piece(red) }
        2.times { |idx| diagonal_up_winner_one.column(idx + 3).add_piece(red) }
        1.times { |idx| diagonal_up_winner_one.column(idx + 4).add_piece(red) }
        4.times { |idx| diagonal_up_winner_one.column(idx + 1).add_piece(yellow) }

        diagonal_up_winner_two = Board.new()
        3.times { |idx| diagonal_up_winner_two.column(idx + 1).add_piece(red) }
        1.times { |idx| diagonal_up_winner_two.column(idx + 4).add_piece(yellow) }
        3.times { |idx| diagonal_up_winner_two.column(idx + 5).add_piece(red) }
        3.times { |idx| diagonal_up_winner_two.column(idx + 4).add_piece(yellow) }
        2.times { |idx| diagonal_up_winner_two.column(idx + 5).add_piece(yellow) }
        1.times { |idx| diagonal_up_winner_two.column(idx + 6).add_piece(yellow) }
        3.times { |idx| diagonal_up_winner_two.column(idx + 3).add_piece(red) }

        expect(diagonal_up_winner_one.winner).to eq("yellow")
        expect(diagonal_up_winner_two.winner).to eq("red")
      end

      it "returns winner color if there is a diagonal down winner" do
        diagonal_down_winner_one = Board.new()
        3.times { |idx| diagonal_down_winner_one.column(idx + 2).add_piece(red) }
        2.times { |idx| diagonal_down_winner_one.column(idx + 2).add_piece(red) }
        1.times { |idx| diagonal_down_winner_one.column(idx + 2).add_piece(red) }
        4.times { |idx| diagonal_down_winner_one.column(idx + 2).add_piece(yellow) }

        diagonal_down_winner_two = Board.new()
        3.times { |idx| diagonal_down_winner_two.column(idx + 1).add_piece(red) }
        1.times { |idx| diagonal_down_winner_two.column(idx + 4).add_piece(yellow) }
        3.times { |idx| diagonal_down_winner_two.column(idx + 5).add_piece(red) }
        3.times { |idx| diagonal_down_winner_two.column(idx + 2).add_piece(yellow) }
        2.times { |idx| diagonal_down_winner_two.column(idx + 2).add_piece(yellow) }
        1.times { |idx| diagonal_down_winner_two.column(idx + 2).add_piece(yellow) }
        3.times { |idx| diagonal_down_winner_two.column(idx + 3).add_piece(red) }

        expect(diagonal_down_winner_one.winner).to eq("yellow")
        expect(diagonal_down_winner_two.winner).to eq("red")
      end
    end

    context "when there is not a winning player" do
      it "returns false" do
        expect(empty_board.winner).to eq(false)
        expect(mixed_board.winner).to eq(false)
      end
    end
  end
end
