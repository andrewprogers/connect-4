require_relative "../lib/piece"

describe "Piece" do
  let(:yellow) { Piece.new("yellow", "@") }
  let(:red) { Piece.new("red", "X") }

  describe "#initialize" do
    it "creates an instance of Piece, taking color and character" do
      expect(yellow).to be_instance_of(Piece)
      expect(red).to be_instance_of(Piece)
    end

    it "throws an error if is not red / yellow" do
      expect {
        Piece.new('green', "@")
      }.to raise_error(PieceCreationError)
    end

    it "throws an error if character is longer than 1 char" do
      expect {
        Piece.new('red', "@@")
      }.to raise_error(PieceCreationError)
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
