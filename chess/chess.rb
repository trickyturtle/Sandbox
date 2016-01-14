#!/usr/bin/env ruby

require "awesome_print"
#require File.expand_path('lib/piece/piece')

# USE .succ for string
puts Dir.pwd
Dir.chdir(File.dirname(__FILE__))
DEBUG_BOARD = false
DEBUG_CV = false

class ChessValidator
  def initialize
    @board = Board.new
  end

  #TODO more desciptive name?
  def get_piece
  end

  def read_moves(moves)
    File.open(moves).each do |entry|
      pair = entry.split(" ")
      @moveList.push(pair)
    end
    ap @moveList if DEBUG_CV
  end

  def read_position(pair)
  end

  def run(boardState, moves)
    @board.read_board_state(boardState)
    ap @board if DEBUG_CV
    ap @board.boardArray if DEBUG_CV
    @moveList = []
    read_moves(moves)
    @board.check_moves(@moveList)
  end

end

#TODO may not need this

class Board
  attr_accessor :boardArray, :board

  def initialize
    @boardHash ||= Hash.new{ |row,col| row[col] = Hash.new(&row.default_proc) }
    @board = self
  #  #Hash implementation
  #  @board = Hash.new "--"
  #   (1..8).each do |num|
  #     letter = 'a'
  #     8.times do
  #       key = letter + num.to_s
  #       @board.store(key.to_s, '--')
  #       letter.succ!
  #     end
  #   end
  #   ap "end B:init" if DEBUG_BOARD
  #   ap @board if DEBUG_BOARD
  end

  def read_board_state(boardInput)
    #Array implementation
    rowNum = 1
    File.open(boardInput).each do |line|
      row = line.split(' ')
      col = 'a'
      row.each do |state|
        @boardHash[rowNum][col] = state
        col.succ!
      end
      rowNum += 1
    end
    ap "after readBoard" if DEBUG_BOARD
    ap @boardHash if DEBUG_BOARD
  end

  def check_moves(moveList)

  end

  def make_move(start, finish)
    startRow = @board.convert_location_to_row(start)
    startCol = @board.convert_location_to_col(start)
    finishRow = @board.convert_location_to_row(finish)
    finishCol = @board.convert_location_to_col(finish)

    self.boardArray[finishRow][finishCol] = boardArray[startRow][startCol]
    self.boardArray[startRow][startCol] = '--'

  end

  def convert_location_to_row(location)
    row = 8 - location[1].to_i
  end

  def convert_location_to_col(location)
    col = location[0].ord - 'a'.ord
  end

  def get_piece_at_location(location)
    #converts letter to array index
    col = location[0].ord - 'a'.ord
    row = 8 - location[1].to_i
    @boardArray[row][col]
  end

end

class Piece
  attr_accessor :type, :color, :location, :board

  def initialize(board, location)
    @board = board
    @location = location
  end

  def valid_vertical_line?(startRow, finishRow, col, startColor)
    (startRow..finishRow).each do |i|
      if @board.boardArray[i][col][0] == startColor
        return false
      elsif i != finishRow && @board.boardArray[i][col][0] != '-'
        return false
      end
    end
    true
  end

  def valid_horizontal_line?(startCol, finishCol, row, startColor)
    (startCol..finishCol).each do |i|
      if @board.boardArray[row][i][0] == startColor
        return false
      elsif i != finishRow && @board.boardArray[row][i][0] != '-'
        return false
      end
    end
    true
  end

  def valid_diagonal_line?(start, finish, startColor)
    #TODO fix this terrible method
    startRow = @board.convert_location_to_row(start)
    startCol = @board.convert_location_to_col(start)
    finishRow = @board.convert_location_to_row(finish)
    finishCol = @board.convert_location_to_col(finish)
    x_displacement = finishRow - startRow
    y_displacement = finishCol - startCol

    return false if x_displacement.abs != y_displacement.abs

    #TODO do this with .each
    x_dir = x_displacement / x_displacement.abs
    y_dir = y_displacement / y_displacement.abs

    while startRow != finishRow
      startRow += y_dir
      startCol += x_dir
      if @board.boardArray[startRow][startCol][0] == startColor
        return false
      end
    end

    if @board.boardArray[startRow][startCol][0] != '-'
      return false
    end
    true
  end

end

class Pawn #TODO< Piece

  attr_accessor :direction
  @direction = -1 if @color == 'w'

  def checkMove(start, finish)
    takingPiece = false
    regMove = false
    startJump = false
    startRow = @board.convert_location_to_row(start)
    startCol = @board.convert_location_to_col(start)
    finishRow = @board.convert_location_to_row(finish)
    finishCol = @board.convert_location_to_col(finish)

    #TODO fix syntax
    regMove = true if (startCol==finishCol && (startRow + @direction) == finishRow && @board.get_piece_at_location(finish) == "--")

    #The first check verifies the piece is on the starting row, TODO fix syntax
    startJump = true if (startRow==(3.5+(2.5*@direction)) && (startRow + (@direction * 2)) == finishRow && @board.get_piece_at_location(finish) == "--" && @board.boardArray[finish[0]][finish[1]-@direction] == "--")

    #TODO Fix syntax
    takingPiece = true if ((startRow + @direction) == finishRow && (finishCol-startCol).abs == 1 && board.get_piece_at_location(finish)[1] != @color)

    if (takingPiece || regMove || startJump)
      tempBoard = @board
      tempBoard.make_move(start, finish)
      if false #TODO if tempBoard.king_in_check?(@color, )
        return "ILLEGAL"
      else
        return "LEGAL"
      end
    end
    'ILLEGAL'
  end
end

module Rook #TODO< Piece

  def check_move(start, finish)
    startRow = @board.convert_location_to_row(start)
    startCol = @board.convert_location_to_col(start)
    finishRow = @board.convert_location_to_row(finish)
    finishCol = @board.convert_location_to_col(finish)

    #TODO fix syntax
    if valid_vertical_line(startRow, finishRow, startCol, @color) || valid_horizontal_line(startCol, finishCol, startRow, @color)
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

module Knight
  #TODO extend self, Piece

  def check_move(start, finish)
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

module Bishop
  #TODO extend self, Piece

  def check_move(start, finish)
    if valid_diagonal_line?(start, finish, @color)
      tempBoard = @board
      tempBoard.make_move(start, finish)
      if false#TODO tempBoard.king_in_check?(@color, )
        return "ILLEGAL"
      else
        return "LEGAL"
      end
    end
    "ILLEGAL"
  end
end

module Queen
  #TODO extend self, Piece

  def check_move(start, finish)
    startRow = @board.convert_location_to_row(start)
    startCol = @board.convert_location_to_col(start)
    finishRow = @board.convert_location_to_row(finish)
    finishCol = @board.convert_location_to_col(finish)

    #TODO fix syntax
    if valid_vertical_line(startRow, finishRow, startCol, @color) || valid_horizontal_line(startCol, finishCol, startRow, @color) || valid_diagonal_line?(start, finish, @color)
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

module King
  #TODO extend self, Piece
end

if __FILE__ == $0
  test = ChessValidator.new
  test.run("complex_board.txt", "complex_moves.txt")
else
  ap "__File__!=$0"
  test = new ChessValidator#.run
  test.run("complex_board.txt")
end
