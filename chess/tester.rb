require 'awesome_print'

# def getPieceAtLocation(location, boardArray)
#   col = location[0].ord - 'a'.ord
#   row = 8 - location[1].to_i
#   boardArray[row][col]
# end
#
# boardArray=[
# ["bK", "--", "--", "--", "--", "bB", "--", "--"],
# ["--", "--", "--", "--", "--", "bP", "--", "--"],
# ["--", "bP", "wR", "--", "wB", "--", "bN", "--"],
# ["wN", "--", "bP", "bR", "--", "--", "--", "wP"],
# ["--", "--", "--", "--", "wK", "wQ", "--", "wP"],
# ["wR", "--", "bB", "wN", "wP", "--", "--", "--"],
# ["--", "wP", "bQ", "--", "--", "wP", "--", "--"],
# ["--", "--", "--", "--", "--", "wB", "--", "--"]
# ]
#
# ap getPieceAtLocation('a1', boardArray)
# ap getPieceAtLocation('b2', boardArray)
# ap getPieceAtLocation('c3', boardArray)
# ap getPieceAtLocation('d4', boardArray)
# ap getPieceAtLocation('e5', boardArray)
# ap getPieceAtLocation('a8', boardArray)
# ap getPieceAtLocation('b7', boardArray)
# ap getPieceAtLocation('c6', boardArray)

(1..5, 6..10).each do |i, j|
  puts i
  puts j
end
