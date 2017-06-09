require_relative "../lib/piece"
require_relative "../lib/player"

describe "Piece" do


  let(:yellow) do
    bob = Player.new("Bob", "yellow", "@")
    Piece.new(bob)
  end

  let(:red) do
    tim = Player.new("Tim", "red", "X")
    Piece.new(tim)
  end

  describe "#initialize" do
    it "creates an instance of Piece, taking a Player" do
      expect(yellow).to be_instance_of(Piece)
      expect(red).to be_instance_of(Piece)
    end

    it "has a color reader" do
      expect(yellow.color).to eq('yellow')
    end
  end

  describe "to_s" do
    it "returns a string" do
      expect(yellow.to_s).to be_instance_of(String)
    end

    it "prints a yellow string for yellow pieces" do
      expect(yellow.to_s).to include("\e[33m")
      expect(yellow.to_s).to include("\e[0m")
    end

    it "prints a red string for red pieces" do
      expect(red.to_s).to include("\e[31m")
      expect(red.to_s).to include("\e[0m")
    end

    it "includes the character specified" do
      expect(red.to_s).to include("X")
      expect(yellow.to_s).to include("@")
    end
  end
end
