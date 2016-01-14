module Piece
  class Rook
    attr_accessor :color, :row, :col

    def initialize(color, row, col)
      @color = color
      @row = row
      @col = col
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

    def isValid(position, board)
      out_of_x_range = (position[0] < 'a' || position[0] > 'h')
      out_of_y_range = (position[1] < '1' || position[1] > '8')
      valid = true
      return false if out_of_x_range || out_of_y_range
      valid = false if board[position[1]][position[0]].color == @color
    end
  end
end