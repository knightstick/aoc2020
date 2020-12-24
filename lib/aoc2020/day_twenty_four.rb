module Aoc2020
  module DayTwentyFour
    class << self
      def part_one(input)
        floor = TileFloor.flip_all_with_directions(input)
        floor.flipped_tile_count
      end

      def part_two(input, days = 100)
        floor = TileFloor.flip_all_with_directions(input)
        floor.live(days)
        floor.flipped_tile_count
      end
    end

    class TileFloor
      class << self
        def flip_all_with_directions(input)
          new.tap do |floor|
            input.chomp.split("\n").each do |line|
              floor.flip_tile_with_directions(line)
            end
          end
        end
      end

      def initialize
        @flipped_tiles = {}
      end

      attr_accessor :flipped_tiles

      def flip_tile_with_directions(line, start = [0, 0])
        return flip_tile(start) if line == '' || line.nil?

        new_start, remaining_moves = if line.start_with?('se')
                                       [southeast(*start), line[2..]]
                                     elsif line.start_with?('sw')
                                       [southwest(*start), line[2..]]
                                     elsif line.start_with?('ne')
                                       [northeast(*start), line[2..]]
                                     elsif line.start_with?('nw')
                                       [northwest(*start), line[2..]]
                                     elsif line.start_with?('e')
                                       [east(*start), line[1..]]
                                     elsif line.start_with?('w')
                                       [west(*start), line[1..]]
                                     else
                                       raise "Unknown directions #{line}"
                                     end

        flip_tile_with_directions(remaining_moves, new_start)
      end

      def flip_tile(point)
        current = flipped_tiles[point] || false
        flipped_tiles[point] = !current
      end

      def live(days)
        return if days.zero?

        flip_accoring_to_rules
        remove_noise
        live(days - 1)
      end

      def flip_accoring_to_rules
        new_floor = {}

        flipped_tiles.each do |point, _current|
          (neighbours(*point) + [point]).each do |a_point|
            next if new_floor.key? a_point

            new_floor[a_point] = maybe_flip(a_point)
          end
        end

        self.flipped_tiles = new_floor
      end

      def remove_noise
        flipped_tiles.each do |key, value|
          flipped_tiles.delete(key) unless value
        end
      end

      def east(x, y)
        [x + 1, y]
      end

      def west(x, y)
        [x - 1, y]
      end

      def northeast(x, y)
        [x, y + 1]
      end

      def northwest(x, y)
        [x - 1, y + 1]
      end

      def southeast(x, y)
        [x + 1, y - 1]
      end

      def southwest(x, y)
        [x, y - 1]
      end

      def flipped_tile_count
        flipped_tiles.values.count(&:itself)
      end

      def maybe_flip(point)
        black_neighbour_count = neighbours(*point).map do |neighbour_point|
          flipped_tiles[neighbour_point]
        end.count(&:itself)

        if flipped_tiles[point]
          !(black_neighbour_count.zero? || (black_neighbour_count > 2))
        else
          black_neighbour_count == 2
        end
      end

      def neighbours(x, y)
        [
          east(x, y),
          west(x, y),
          northeast(x, y),
          northwest(x, y),
          southeast(x, y),
          southwest(x, y)
        ]
      end
    end
  end
end
