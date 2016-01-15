require_relative 'piece'
require_relative 'piece/king'
require_relative 'piece/queen'
require_relative 'piece/rook'
require_relative 'piece/knight'
require_relative 'piece/bishop'
require_relative 'piece/pawn'
require_relative 'piece/empty'


module ChessValidator
  class Board
    attr_accessor :boardHash, :moveHash, :moveList, :blackMoves, :whiteMoves


    def initialize
      #Hash implementation
      @boardHash ||= Hash.new{ |row1,col1| row1[col1] = Hash.new(&row1.default_proc) }
      @moveHash ||= Hash.new{ |row2,col2| row2[col2] = Hash.new(&row2.default_proc) }
      @moveList ||= []
      @blackMoves ||= []
      @whiteMoves ||= []
    end

    def read_board_state(boardInput)
      #Array implementation
      rowNum = 8
      File.open(boardInput).each do |line|
        row = line.split(' ')
        col = "a"

        row.each do |state|
          #ap "in read_board_state: #{col}"
          @boardHash[rowNum][col] = get_piece(state, rowNum, col)
          #ap @boardHash[rowNum][col]
          @moveHash[rowNum][col] = "--"
          #ap moveHash[rowNum][col]
          col = col.next
          #col.succ! was converting all col variables...
          #ap @boardHash
        end
        rowNum -= 1
      end
      ap "after readBoard" if DEBUG_BOARD
      ap @boardHash if DEBUG_BOARD
    end

    def get_piece(piece_string, row, col)
      new_piece = nil
      color = piece_string[0]
      case piece_string[1]
      when 'P'
        new_piece = Piece::Pawn.new(color, row, col)
      when 'R'
        new_piece = Piece::Rook.new(color, row, col)
      when 'B'
        new_piece = Piece::Bishop.new(color, row, col)
      when 'N'
        new_piece = Piece::Knight.new(color, row, col)
      when 'Q'
        new_piece = Piece::Queen.new(color, row, col)
      when 'K'
        new_piece = Piece::King.new(color, row, col)
      else
        new_piece = Piece::Empty.new(color, row, col)
      end
    end

    def read_moves(moves)
      File.open(moves).each do |entry|
        pair = entry.split(" ")
        @moveList.push(pair)
      end
      ap @moveList if DEBUG_CV
    end

    def check_moves
      #ap @moveList
      @moveList.each do |pair|
        pieceRow = pair[0][1]
        pieceCol = pair[0][0]
        moves = @moveHash[pieceRow.to_i][pieceCol]
        valid = "ILLEGAL"

        moves.each do |move|
          if move == pair[1]
            valid = 'LEGAL'
            break
          end
        end
        #puts "#{pair} #{valid}"
        puts valid
      end
    end




    # def make_move(start, finish)
    #   startRow = @board.convert_location_to_row(start)
    #   startCol = @board.convert_location_to_col(start)
    #   finishRow = @board.convert_location_to_row(finish)
    #   finishCol = @board.convert_location_to_col(finish)
    #
    #   self.boardArray[finishRow][finishCol] = boardArray[startRow][startCol]
    #   self.boardArray[startRow][startCol] = '--'
    #
    # end

    def get_move_lists
      kings = []
      @boardHash.each do |rowNum, row|

        row.each do |col, piece|

          if piece.class == Piece::King
            kings.push(piece)
          end

          @moveHash[rowNum][col] = piece.get_move_list(@boardHash)
          if piece.color == "w"
            @whiteMoves = [@whiteMoves, @moveHash[rowNum][col]].flatten.compact
          elsif piece.color == "b"
            @blackMoves = [@blackMoves, @moveHash[rowNum][col]].flatten.compact
          end
        end
      end
      kings.each do |king|
        if king.color == "w"
          @moveHash[king.row][king.col].each do |move|
            @blackMoves.each do |threat|
              if threat == move
                @moveHash[king.row][king.col].delete(move)
                break
              end
            end
          end
        else
          @moveHash[king.row][king.col].each do |move|
            @whiteMoves.each do |threat|
              if threat == move
                @moveHash[king.row][king.col].delete(move)
              end
            end
          end
        end
      end
    end

    # def convert_location_to_row(location)
    #   row = 8 - location[1].to_i
    # end
    #
    # def convert_location_to_col(location)
    #   col = location[0].ord - 'a'.ord
    # end
    #
    # def get_piece_at_location(location)
    #   #converts letter to array index
    #   col = location[0].ord - 'a'.ord
    #   row = 8 - location[1].to_i
    #   @boardArray[row][col]
    # end

  end
end
