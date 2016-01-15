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




  def run(boardState, moves)
    @board.read_board_state(boardState)
    ap @board if DEBUG_CV
    ap @board.boardArray if DEBUG_CV
    @board.get_move_lists
    @board.read_moves(moves)
    @board.check_moves(@moveList)
  end

end

#TODO may not need this



end



if __FILE__ == $0
  test = ChessValidator.new
  test.run("complex_board.txt", "complex_moves.txt")
else
  ap "__File__!=$0"
  test = new ChessValidator#.run
  test.run("complex_board.txt")
end
