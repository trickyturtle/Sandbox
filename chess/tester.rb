require 'awesome_print'
Dir.chdir(File.dirname(__FILE__))
# class Board
#   attr_accessor :board, :boardArray
#
#   def initialize
#     @board = self
#     @boardArray ||= []
#   end
#
#   def convert_location_to_row(location)
#     row = 8 - location[1].to_i
#   end
#
#   def convert_location_to_col(location)
#     col = location[0].ord - 'a'.ord
#   end
#
#   def make_move(start, finish)
#     startRow = @board.convert_location_to_row(start)
#     startCol = @board.convert_location_to_col(start)
#     finishRow = @board.convert_location_to_row(finish)
#     finishCol = @board.convert_location_to_col(finish)
#
#     self.boardArray[finishRow][finishCol] = boardArray[startRow][startCol]
#     self.boardArray[startRow][startCol] = '--'
#
#   end
#
#   def read_board_state(boardInput)
#     #Array implementation
#     File.open(boardInput).each { |row| @boardArray.push(row.split(" ")) }
#   end
# end
#
# board = Board.new
# board.read_board_state('complex_board.txt')
# ap board.boardArray
# board.make_move("f2", 'f3')
# ap board.boardArray
# board2 = board
# ap board2.boardArray
# board2.make_move("h5", 'h4')
# ap board.boardArray
# ap board2.boardArray

hash1 = Hash.new{ |row,col| row[col] = Hash.new(&row.default_proc) }
#hash2 = Hash.new{ |row,col| row[col] = Hash.new (&row => '--') }

hash1[:'1'][:a]
hash1[2][:b]
hash1[:'3'][:c] = 'bK'
hash1[4][:d] = 'wR'
hash1[:'1'][:e] = "bQ"
hash1[2][:f] = 'wT'

# hash2[:'1'][:a]
# hash2[2][:b]
# hash2[:'3'][:c] = 'bK'
# hash2[4][:d] = 'wR'
# hash2[:'1'][:e] = "bQ"
# hash2[2][:f] = 'wT'



hash1.each do |key, value|
  puts key
  puts value
  value.each do |key2, value2|
    puts key2
    puts value2
  end
end
# ap hash2
