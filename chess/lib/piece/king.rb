module Piece
  class King
    #extend ChessValidator::Piece
    #include ChessValidator

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

    def move_vertical(board)
      moveList = []
      moveMatrix = [1, -1]

      moveMatrix.each do |transform|
        newRow = @row + transform
        moveList.push("#{@col}#{newRow.to_s}") if isValid?("#{@col}#{newRow.to_s}", board)
      end

      moveList
    end

    def move_horizontal(board)
      moveList = []
      moveMatrix = [1, -1]

      moveMatrix.each do |transform|
        newCol = (@col.ord + transform).chr
        moveList.push("#{newCol}#{@row.to_s}") if isValid?("#{newCol}#{@row.to_s}", board)
      end

      moveList
    end

    def move_diagonal(board)
      moveMatrix = [1, -1]
      moveList = []

      moveMatrix.each do |xTransform|
        newCol = (@col.ord + xTransform).chr

        moveMatrix.each do |yTransform|
          newRow = @row + yTransform

          if isValid?("#{newCol}#{newRow.to_s}", board)
            moveList.push("#{newCol}#{newRow.to_s}")
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
