module Piece
  class Piece
    extend MoveValidator::ClassMethods
    include MoveValidator

    attr_accessor :type, :color, :location, :board

    def initialize(board, location)
      @board = board
      @location = location
    end
  end
end
