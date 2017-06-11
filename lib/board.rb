require_relative "column"

class Board
  attr_reader :columns, :winner

  def initialize
    @columns = Array.new(7) { Column.new() }
    @winner = false
  end

  def column(col_num)
    if [*(1..7)].include?(col_num)
      @columns[col_num - 1]
    else
      nil
    end
  end

  def full?
    @columns.each do |col|
      return false unless col.full?
    end
    return true
  end

  def print_board
    system "clear" or system "cls"
    top = "┏━━━┯━━━┯━━━┯━━━┯━━━┯━━━┯━━━┓\n"
    row_sep = "┠───┼───┼───┼───┼───┼───┼───┃\n"
    bottom = <<~EOS
      ╋━━━┷━━━┷━━━┷━━━┷━━━┷━━━┷━━━╋
      ┃                           ┃
      ┻                           ┻
    EOS
    rows_from_top = [*(1..6)].reverse
    row_strings = rows_from_top.map { |row| row_string(row_chars(row))}
    board_body = row_strings.join(row_sep)
    print top
    print board_body
    print bottom
  end

  def winner
    return @winner if @winner.class == Player

    (1..7).each do |col|
      (1..6).each do |row|
        next if column(col).row(row).nil?
        @winner = column(col).row(row).player if any_win?(row, col)
      end
    end
    return @winner
  end

  private
  def row_chars(row)
    @columns.map { |col| col.row_to_s(row)}
  end

  def row_string(row_piece_chars)
    inner_row = row_piece_chars.map { |char| " #{char} " }.join("│")
    "┃#{inner_row}┃\n"
  end

  def any_win?(r, c)
    return false if column(c).row(r).nil?

    up_win?(r, c) || right_win?(r, c) ||
    diag_up_win?(r, c) || diag_down_win?(r, c)
  end

  def up_win?(r, c)
    four_in_a_row?(r, c, 1, 0)
  end

  def right_win?(r, c)
    four_in_a_row?(r, c, 0, 1)
  end

  def diag_up_win?(r, c)
    four_in_a_row?(r, c, 1, 1)
  end

  def diag_down_win?(r, c)
    four_in_a_row?(r, c, -1, 1)
  end

  def four_in_a_row?(r, c, r_inc, c_inc)
    cell = column(c).row(r)

    (1..3).each do
      c += c_inc
      r += r_inc
      return false if column(c).nil? || column(c).row(r).nil?
      return false unless cell.color == column(c).row(r).color
    end
    return true
  end
end
