class Tile
  attr_accessor :tile_type, :value, :is_dora

  def initialize(tile_type, value)
    @tile_type = tile_type
    @value = value
    @is_dora = false
  end
end
