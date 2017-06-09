require_relative "../lib/player"

describe "Player" do
  let(:pone) { Player.new("Player One", "yellow", "#")}
  let(:ptwo) { Player.new("Player two", "red", "@@")}
  describe "#initialize" do
    it "creates a Player object" do
      expect(pone).to be_instance_of(Player)
    end

    it "has a color reader" do
      expect(pone.color).to eq("yellow")
    end

    it "has a character reader" do
      expect(pone.character).to eq("#")
    end

    it "has a name reader" do
      expect(pone.name).to eq("Player One")
    end

    it "throws an error if symbol is greater than one character" do
      expect { ptwo }.to raise_error(PlayerCreationError)
    end
  end
end
