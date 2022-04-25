class Tileset
  SUITS = ["Dots", "Bamboo", "Numbers"]
  SUITED_TILES = SUITS.product((1..9).to_a).map{ |suit, value| { type: suit, value: value } }
  WIND_TILES = WINDS.map{ |wind| { type: "Wind", value: wind } }
  DRAGON_TILES = %w[Red Green White].map{ |color| { type: "Dragon", value: color } }
  FULL_TILE_SET = [SUITED_TILES, WIND_TILES, DRAGON_TILES].flatten * 4

  attr_accessor :tiles, :walls, :roll

  def initialize
    @roll = rand(1..11)
    @tiles = FULL_TILE_SET.map{ |tile| Tile.new(tile[:type], tile[:value]) }.shuffle
    set_walls
  end

  private

  def set_walls
    split_tileset = @tiles.each_slice(34).to_a
    @walls = WINDS.map.with_index{ |wind, i| [wind, split_tileset[i]] }.to_h

    set_dead_wall
  end

  def set_dead_wall
    wall_index = @roll % 4
    broken_wall = @walls[WINDS[wall_index]]
    dead_range = calculate_dead_range

    dead_wall = broken_wall.slice!(dead_range)
    dead_wall[8].is_dora = true
    @walls[:dead_wall] = dead_wall

    supplement_dead_wall(wall_index+1) if dead_wall.count == 12
  end

  def calculate_dead_range
    break_point = @roll * 2
    break_end = break_point + 13

    break_point..break_end
  end

  def supplement_dead_wall(wall_index)
    supplemental_wall = @walls[WINDS[wall_index%4]]
    @walls[:dead_wall] += supplemental_wall.slice!(0..1)
  end
end
