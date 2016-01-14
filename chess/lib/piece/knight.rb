module Piece
  class Knight
    attr_accessor :color, :row, :col

    def initialize(color, row, col)
      @color = color
      @row = row
      @col = col
    end

    def isValid(position, board)
      out_of_x_range = (position[0] < 'a' || position[0] > 'h')
      out_of_y_range = (position[1] < '1' || position[1] > '8')
      valid = true
      return false if out_of_x_range || out_of_y_range
      valid = false if board[position[1]][position[0]].color == @color
    end

    def check_move(board)
      startRow = @board.convert_location_to_row(start)
      startCol = @board.convert_location_to_col(start)
      finishRow = @board.convert_location_to_row(finish)
      finishCol = @board.convert_location_to_col(finish)
      
      x_displacement = finishRow - startRow
      y_displacement = finishCol - startCol
      if [x_displacement.abs, y_displacement.abs].sort == [1, 2]
        tempBoard = @board
        tempBoard.make_move(start, finish)
        if false #TODO if tempBoard.king_in_check?(@color, )
          return "ILLEGAL"
        else
          return "LEGAL"
        end
      end
      "ILLEGAL"
    end
  end
end
