class Piece
  attr_accessor :type, :color, :location, :board

  def initialize(board, location)
    @board = board
    @location = location
  end
end

class Pawn < Piece

  attr_accessor :direction
  @direction = -1 if @color == 'w'

  def checkMove(start, finish)
    takingPiece = false
    regMove = false
    startJump = false
    isValid = ''

    regMove = true if (start[0]==finish[0] && (start[1] + @direction) == finish[1] && board.boardArray[finish[0]][finish[1]] == "--")

    #The first check verifies the piece is on the starting row
    startJump = true if (start[1]==(3.5+(-2.5*@direction)) && (start[1] + (@direction * 2)) == finish[1] && board.boardArray[finish[0]][finish[1]] == "--" && board.boardArray[finish[0]][finish[1]-@direction] == "--")

    #TODO takingPiece

    #TODO fix syntax
    if (takingPiece || regMove || startJump)
      isValid = "LEGAL"
    else
      isValid "ILLEGAL"
    end
  end


end

module Rook < Piece

  def check_move(start, finish)
    isLine = false
    direction = false
    direction = 'col' if start[0]==finish[0]
    direction = 'row' if start[1]==finish[1]

    #check move is a line
    return "ILLEGAL" if !(direction)

    #check end location is not occupied by team
    endContains = board[finish]
    return "ILLEGAL" if endContains[0] == self.color

    #check no pieces are jumped
    case direction
    when 'col'
      #TODO stop short of final pos
      #TODO ask about this syntax (single line would be long)
      (start[0]..(finish[0])).each do |pos|
        return "ILLEGAL" if boardArray[pos][start[1]] != "--"
      end
    when 'row'
      #TODO stop short of final pos
      (start[1]..(finish[1])).each do |pos|
        return "ILLEGAL" if boardArray[start[0]][pos] != "--"
      end
    end
    "LEGAL"
  end
end

module Knight
  extend self, Piece
end

module Bishop
  extend self, Piece
end

module Queen
  extend self, Piece
end

module King
  extend self, Piece
end

if __FILE__ == $0
  test = ChessValidator.new
  test.run("complex_board.txt", "complex_moves.txt")
else
  ap "__File__!=$0"
  test = new ChessValidator#.run
  test.run("complex_board.txt")
end
