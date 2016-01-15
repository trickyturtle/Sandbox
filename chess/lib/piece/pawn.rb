

module Piece
  class Pawn
    attr_accessor :color, :row, :col, :direction
    DEBUG_PAWN = false

    def initialize(color, row, col)
      @color = color
      @row = row
      @col = col
      @direction = @color == 'w' ? 1 : -1
    end

  # def check_move(start, finish)
  #   takingPiece = false
  #   regMove = false
  #   startJump = false
  #   isValid = ''
  #
  #   regMove = true if (start[0]==finish[0] && (start[1] + @direction) == finish[1] && board.boardArray[finish[0]][finish[1]] == "--")
  #
  #   #The first check verifies the piece is on the starting row
  #   startJump = true if (start[1]==(3.5+(-2.5*@direction)) && (start[1] + (@direction * 2)) == finish[1] && board.boardArray[finish[0]][finish[1]] == "--" && board.boardArray[finish[0]][finish[1]-@direction] == "--")
  #
  #   #TODO takingPiece
  #
  #   #TODO fix syntax
  #   if (takingPiece || regMove || startJump)
  #     isValid = "LEGAL"
  #   else
  #     isValid "ILLEGAL"
  #   end
  # end

    def move_one(board)
      newRow = @row + @direction

      if board[newRow][col].color == '--'
        newPos = "#{@col}#{newRow.to_s}"
      else
        nil
      end
    end

    def move_two(board)
      #ap board
      pawnStart = @color == 'w' ? 2 : 7
      newRow = @row + 2 * @direction
      piece = board[newRow][@col]
      #TODO
      ap piece
      ap newRow
      ap @col
      isClear = board[newRow][@col].color == '--' && board[newRow-@direction][@col].color == '--'

      if @row == pawnStart && isClear
        newPos = "#{@col}#{newRow.to_s}"
      else
        nil
      end
    end

    #TODO fix by incorporating isValid
    def move_diagonal(board)
      newRow = @row + @direction
      leftCol = (@col.ord - 1).chr #decrement char
      rightCol = @col.next
      leftMove = board[newRow].has_key?(leftCol) ? board[newRow][leftCol] : false
      rightMove = board[newRow].has_key?(rightCol) ? board[newRow][rightCol] : false
      validArray = []
      if DEBUG_PAWN
        ap "in pawn: #{board}"
        ap newRow
        ap rightCol
        ap leftCol
        ap leftMove
        ap rightMove
      end



      if leftMove
        if leftMove.color == '--' || leftMove.color == @color
          validArray.push(nil)
        else
          validArray.push("#{leftCol}#{newRow.to_s}")
        end
      end
      ap rightMove if DEBUG_PAWN

      if rightMove
        if rightMove.color == '--' || rightMove.color == @color
          validArray.push(nil)
        else
          validArray.push("#{rightCol}#{newRow.to_s}")
        end
      end
      validArray
    end

    def isValid?(position, board)
      out_of_x_range = (position[0] < 'a' || position[0] > 'h')
      out_of_y_range = (position[1] < '1' || position[1] > '8')
      valid = true
      return false if out_of_x_range || out_of_y_range
      valid = false if board[position[1]][position[0]].color == @color
    end

    def get_move_list(board)
      moveList = [move_diagonal(board), move_one(board), move_two(board)].flatten.compact
    end
  end
end
