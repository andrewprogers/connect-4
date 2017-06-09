require_relative "../lib/column"

describe "Column" do
  let(:red_piece)  do
    tim = Player.new("Tim", "red", "@")
    Piece.new(tim)
  end
  let(:empty) { Column.new() }
  let(:one) {
    c = Column.new()
    c.add_piece(red_piece)
    c
  }
  let(:five) {
    c = Column.new()
    5.times { c.add_piece(red_piece) }
    c
  }
  let(:six) {
    c = Column.new()
    6.times { c.add_piece(red_piece) }
    c
  }
  describe "#initialize" do
    it "creates a new column" do
      expect(empty).to be_instance_of(Column)
    end
  end

  describe "#full?" do
    it "returns false when column has less than 6 pieces" do
      expect(empty.full?).to eq(false)
      expect(one.full?).to eq(false)
      expect(five.full?).to eq(false)
    end

    it "returns true when column has 6 pieces" do
      expect(six.full?).to eq(true)
    end
  end

  describe "#add_piece" do
    it "throws an IllegalPlay error if method called when column is full" do
      expect {
        six.add_piece(red_piece)
      }.to raise_error(IllegalPlayError)
    end

    it "adds a piece to the column" do
      col = five
      expect(col.full?).to eq(false)
      col.add_piece(red_piece)
      expect(col.full?).to eq(true)
    end
  end

  describe "#row(n)" do
    it "returns a Piece if there is a piece at index (n - 1)" do
      expect(one.row(1)).to be_instance_of(Piece)
      expect(five.row(3)).to be_instance_of(Piece)
      expect(six.row(6)).to be_instance_of(Piece)
    end

    it "returns nil if there is no piece at index (n - 1)" do
      expect(five.row(6)).to be_nil
      expect(six.row(7)).to be_nil
      expect(six.row(0)).to be_nil
    end
  end

  describe "#row_to_s" do
    it "returns ' ' when the row is empty" do
      expect(one.row_to_s(2)).to eq(' ')
    end
    it "returns the string representation of a piece when the piece is in the row" do
      expect(one.row_to_s(1)).to eq("\e[31m@\e[0m")
    end
  end
end
