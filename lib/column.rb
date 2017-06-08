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

  def row_to_s(row)
    piece = @stack[row - 1]
    if piece.nil?
      ' '
    else
      piece.to_s
    end
  end
end
