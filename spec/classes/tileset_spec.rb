require "rails_helper"

RSpec.describe Tileset do
  describe "#initialize" do
    before do
      @tileset = Tileset.new
    end

    context "tiles" do
      it "contains 136 tiles" do
        expect(@tileset.tiles.count).to eq(136)
      end

      it "contains 5 unique tile types" do
        tile_types = @tileset.tiles.map(&:tile_type).uniq

        expect(tile_types.count).to eq(5)
      end

      it "contains 34 unique tiles" do
        tiles = @tileset.tiles.map{ |tile| [tile.tile_type, tile.value] }.uniq

        expect(tiles.count).to eq(34)
      end
    end

    context "walls" do
      it "generates a wall for each wind" do
        walls = @tileset.walls.keys

        expect(WINDS.all?{ |wind| walls.include?(wind) }).to be(true)
      end

      it "generates at least 2 walls consisting of 34 tiles" do
        full_walls = @tileset.walls.select{ |_key, value| value.count == 34 }

        expect(full_walls.count >= 2).to be(true)
      end

      it "generates a dead wall of 14 tiles" do
        dead_wall = @tileset.walls[:dead_wall]

        expect(dead_wall.count).to eq(14)
      end

      it "designates the 9th tile of the dead wall as the dora" do
        dora_tile = @tileset.walls[:dead_wall][8]

        expect(dora_tile.is_dora).to be(true)
      end
    end
  end
end
