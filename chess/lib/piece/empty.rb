module Piece
  class Empty
    attr_accessor :color, :row, :col

    def initialize(color, row, col)
      @color = '--'
      @row = row
      @col = col
    end
  end
end
