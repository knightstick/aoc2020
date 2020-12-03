# frozen_string_literal: true

module Aoc2020
  class DayThree
    class << self
      def part_one(input)
        grid = Grid.from_string(input)
        toboggan_ride = TobogganRide.new(grid: grid)
        toboggan_ride.number_of_trees
      end
    end

    class Grid
      class << self
        def from_string(string)
          lines = string.chomp.split("\n")
          new(coordinates: build_coordinates(lines), width: lines.first.length, height: lines.size)
        end

        private

        def build_coordinates(lines)
          lines.each_with_index.reduce({}) do |memo, (line, x_coord)|
            line.chars.each_with_index.reduce(memo) do |inner_memo, (char, y_coord)|
              inner_memo.merge({ x: x_coord, y: y_coord } => square(char))
            end
          end
        end

        def square(char)
          case char
          when '#'
            Tree.new
          when '.'
            NotATree.new
          else
            raise 'Unknown geology'
          end
        end
      end

      def initialize(coordinates:, width:, height:)
        @coordinates = coordinates
        @width = width
        @height = height
      end

      def at(position)
        coordinates.fetch(position)
      end

      def in_bounds?(position)
        coordinates.keys.include?(position)
      end

      def next_position(x:, y:, x_diff:, y_diff:)
        new_x = x + x_diff
        return unless new_x < height

        {
          x: new_x,
          y: (y + y_diff) % width
        }
      end

      private

      attr_reader :coordinates,
                  :width,
                  :height
    end

    class Tree
      def tree?
        true
      end
    end

    class NotATree
      def tree?
        false
      end
    end

    class TobogganRide
      def initialize(grid:)
        @grid = grid
      end

      def number_of_trees
        path.count(&:tree?)
      end

      private

      attr_reader :grid

      def path
        @path ||= calculate_path
      end

      def calculate_path
        initial_position = { x: 0, y: 0 }
        position = initial_position

        result = []

        while position
          result.push(grid.at(position))
          position = grid.next_position(x_diff: 1, y_diff: 3, **position)
        end

        result
      end
    end
  end
end
