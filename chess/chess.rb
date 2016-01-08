#!/usr/bin/env ruby

require 'awesome_print'

DEBUG_BOARD = false
DEBUG_CV = true

class ChessValidator
  def initialize
    @board = Board.new
  end

  #TODO more desciptive name?
  def getPiece
  end

  def readMoves(moves)
    File.open(moves).each do |entry|
      pair = entry.split(" ")
      @moveList.push(pair)
    end
    ap @moveList if DEBUG_CV
  end

  def readPosition(pair)
  end

  def run(boardState, moves)
    @board.readBoardState(boardState)
    ap @board if DEBUG_CV
    ap @board.boardArray if DEBUG_CV
    @moveList = []
    readMoves(moves)
    @board.checkMoves(@moveList)
  end

end

#TODO may not need this

class Board
  attr_accessor :board, :letters, :boardArray

  def initialize
    #Hash implementation
    letters = ["a", "b", "c", "d", "e", "f", "g", "h",]
    @board = Hash.new "--"
    @boardArray = []

    (1..8).each do |num|
      letters.each do |letter|
        key = letter + num.to_s
        @board.store(key.to_s, '--')
      end
    end
    ap "end B:init" if DEBUG_BOARD
    ap @board if DEBUG_BOARD
  end

  def readBoardState(boardInput)
    #Array implementation
    File.open(boardInput).each do |row|
      @boardArray.push(row.split(" "))
    end
    ap "after readBoard" if DEBUG_BOARD
    ap @boardArray if DEBUG_BOARD
  end

  def checkMoves(moveList)

  end

end

module Piece
  attr_accessor :type, :color, :location

end

module Pawn
  extend self, Piece

  attr_accessor :direction
  @direction = -1 if @color == 'white'

  def checkMove(start, finish)
    takingPiece = false
    regMove = false
    startJump = false

    regMove = true if (start[0]==finish[0] && (start[1] + @direction) == finish[1] && board.boardArray[finish[0]][finish[1]] == "--")
    #The first check verifies the piece is on the starting row
    startJump = true if (start[1]==(3.5+(-2.5*@direction)) && (start[1] + (@direction * 2)) == finish[1] && board.boardArray[finish[0]][finish[1]] == "--" && board.boardArray[finish[0]][finish[1]-@direction] == "--")
    #TODO takingPiece
    if (takingPiece || regMove || startJump)
      ap "LEGAL"
    else
      ap "ILLEGAL"
    end
  end


end

module Rook
  extend self, Piece
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
  test.run('chess/complex_board.txt', 'chess/complex_moves.txt')
else
  ap "__File__!=$0"
  test = new ChessValidator#.run
  test.run('chess/complex_board.txt')
end
