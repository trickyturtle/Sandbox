module Piece
  class Queen
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

    def move_vertical(board)
      moveList = []
      moveMatrix = [-1, 1]

      moveMatrix.each do |transform|
        newRow = @row + transform
        jumped = false
        while isValid?(@col << newRow, board) && !jumped
          moveList.push(@col << newRow)
          jumped = true if board[newRow][@col].color != '--'
          newRow += transform
        end
      end

      moveList
    end

    def move_horizontal(board)
      moveList = []
      moveMatrix = [-1, 1]

      moveMatrix.each do |transform|
        newCol = (@col.ord + transform).chr
        jumped = false

        while isValid?(newCol << @row, board) && !jumped
          moveList.push(newCol << @row)
          jumped = true if board[@row][newCol].color != '--'
          newCol = (newCol.ord + transform).chr
        end
      end

      moveList
    end

    def move_diagonal(board)
      moveMatrix = [1, -1]
      moveList = []

      moveMatrix.each do |xTransform|
        newCol = (@col.ord + xTransform).chr

        moveMatrix.each do |yTransform|
          jumped = false
          newRow = @row + yTransform

          while isValid?(newCol << newRow, board) && !jumped
            moveList.push(newCol << newRow)
            jumped = true if board[newRow][newCol].color != '--'
            newCol = (newCol.ord + xTransform).chr
            newRow += yTransform
          end
        end
      end
      moveList
    end

    def get_move_list(board)
      moveList = [move_vertical(board), move_horizontal(board), move_diagonal(board)].flatten.compact
    end
  end
end
