#!/usr/bin/env ruby

require "awesome_print"
require_relative 'lib/board'
#require File.expand_path('lib/piece/piece')

# USE .succ for string?

Dir.chdir(File.dirname(__FILE__))
DEBUG_BOARD = false
DEBUG_CV = false

module ChessValidator
  extend self
  def initialize
    #@board = ChessValidator::Board.new
  end




  def run(boardState, moves)
    board = ChessValidator::Board.new
    board.read_board_state(boardState)
    ap board if DEBUG_CV
    ap board.boardArray if DEBUG_CV
    board.get_move_lists
    board.read_moves(moves)
    board.check_moves
  end

end





if __FILE__ == $0
  ChessValidator.run("complex_board.txt", "complex_moves.txt")
else
  ap "__File__!=$0"
  test = new ChessValidator#.run
  test.run("complex_board.txt")
end
