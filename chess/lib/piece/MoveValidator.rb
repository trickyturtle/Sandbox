module Piece
  module MoveValidator
    module ClassMethods
      attr_accessor :moveValidators

      def moveValidators
        @moveValidators ||= []
      end

      def movement_valid?()

      def validate_type(method)
        moveValidators << method
      end


    end
  end
end
