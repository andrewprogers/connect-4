require_relative "column"

class Board
  attr_reader :columns

  def initialize
    @columns = Array.new(7) { Column.new() }
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
    (1..7).each do |col|
      (1..6).each do |row|
        next if column(col).row(row).nil?
        cell_color = column(col).row(row).color
        return cell_color if upwards_win?(row, col)
        return cell_color if right_win?(row, col)
        return cell_color if diagonal_up_win?(row, col)
      end
    end
  end

  private
  def row_chars(row)
    @columns.map { |col| col.row_to_s(row)}
  end

  def row_string(row_piece_chars)
    inner_row = row_piece_chars.map { |char| " #{char} " }.join("│")
    "┃#{inner_row}┃\n"
  end

  def upwards_win?(r, c)
    this_cell = column(c).row(r)
    return false if this_cell.nil?

    (1..3).each do |num|
      next_cell = column(c).row(r + num)
      return false if next_cell.nil?
      return false unless this_cell.color == next_cell.color
    end
    return true
  end

  def right_win?(r, c)
    this_cell = column(c).row(r)
    return false if this_cell.nil?

    (1..3).each do |num|
      return false if column(c + num).nil?
      next_cell = column(c + num).row(r)
      return false if next_cell.nil?
      return false unless this_cell.color == next_cell.color
    end
    return true
  end

  def diagonal_up_win?(r, c)
    this_cell = column(c).row(r)
    return false if this_cell.nil?

    (1..3).each do |num|
      return false if column(c + num).nil?
      next_cell = column(c + num).row(r + num)
      return false if next_cell.nil?
      return false unless this_cell.color == next_cell.color
    end
    return true
  end
end
