module Piece
  class Bishop
    attr_accessor :color, :row, :col

    def initialize(color, row, col)
      @color = color
      @row = row
      @col = col
    end

    def move_diagonal(board)
      moveMatrix = [1, -1]
      moveList = []

      moveMatrix.each do |xTransform|
        newCol = (@col.ord + xTransform).chr

        moveMatrix.each do |yTransform|
          jumped = false
          newRow = @row + yTransform

          while isValid?("#{newCol}#{newRow.to_s}", board) && !jumped
            moveList.push("#{newCol}#{newRow.to_s}")
            jumped = true if board[newRow][newCol].color != '--'
            newCol = (newCol.ord + xTransform).chr
            newRow += yTransform
          end
        end
      end
      moveList
    end

    def isValid?(position, board)
      out_of_x_range = (position[0] < 'a' || position[0] > 'h')
      out_of_y_range = (position[1] < '1' || position[1] > '8')
      valid = true
      return false if out_of_x_range || out_of_y_range
      valid = false if board[position[1]][position[0]].color == @color
    end


    def get_move_list(board)
      moveList = [move_diagonal(board)].flatten.compact
    end
  end
end
