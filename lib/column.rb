class IllegalPlayError < StandardError
end

class Column
  def initialize
    @stack = []
  end

  def full?
    @stack.length == 6
  end

  def add_piece(piece)
    raise IllegalPlayError if full?
    @stack << piece
  end

  def row(row_num)
    if [*(1..@stack.length)].include?(row_num)
      @stack[row_num - 1]
    else
      nil
    end
  end

  def row_to_s(row)
    piece = @stack[row - 1]
    if piece.nil?
      ' '
    else
      piece.to_s
    end
  end
end
