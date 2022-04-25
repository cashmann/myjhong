require "rails_helper"

RSpec.describe Tile do
  describe "#initailize" do
    before do
      @tile = Tile.new("Foo", "bar")
    end

    it "sets the tile type" do
      expect(@tile.tile_type).to eq("Foo")
    end

    it "sets the tile value" do
      expect(@tile.value).to eq("bar")
    end

    it "defaults the 'is_dora' attribute to false" do
      expect(@tile.is_dora).to be(false)
    end
  end
end
