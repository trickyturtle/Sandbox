module Piece
  class Knight
    attr_accessor :color, :row, :col

    def initialize(color, row, col)
      @color = color
      @row = row
      @col = col
    end

    def isValid?(position, board)
      out_of_x_range = (position[0] < 'a' || position[0] > 'h')
      out_of_y_range = (position[1] < '1' || position[1] > '8')
      valid = true
      return false if out_of_x_range || out_of_y_range
      valid = false if board[position[1]][position[0]].color == @color
    end

    def check_moves(board)
      xyMatrix = [-1, 1]
      positionMatrix = [1, 2]
      moveList = []

      xyMatrix.each do |xSign|
        xyMatrix.each do |ySign|
          positionMatrix.each do |displacement|
            xOffset = displacement * xSign
            yOffset = (3 - displacement) * ySign
            newCol = (@col.ord + xOffset).chr
            newRow = @row + yOffset
            newPos = newCol << newRow
            moveList.push(newPos) if isValid?(newPos, board)
          end
        end
      end
      moveList
    end

    def get_move_list(board)
      moveList = [check_moves(board)].flatten.compact
    end

  end
end
