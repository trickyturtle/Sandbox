require "spec_helper"

describe Piece do
  describe Bishop do
    it "should contain color, row, and col" do
      @bishop = Piece::Bishop.new('b', 8, 'f')
    end
  end

end
