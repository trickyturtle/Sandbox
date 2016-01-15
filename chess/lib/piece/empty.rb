module Piece
  class Empty
    attr_accessor :color, :row, :col

    def initialize(color, row, col)
      @color = '--'
      @row = row
      @col = col
    end

    def get_move_list(board)
      []
    end
  end
end
