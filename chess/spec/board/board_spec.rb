
require "spec_helper"

describe Board do
  let(:board) {Board.new}
  describe ".read_position" do
    context "given a .txt of moves" do
      it "returns an array of movement pairs" do
        expect(.read_moves("complex_moves.txt")).to eql([
      end
    end
end
