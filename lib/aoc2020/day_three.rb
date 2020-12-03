# frozen_string_literal: true

require 'ostruct'

module Aoc2020
  class DayThree
    class << self
      def part_one(input)
        grid = Grid.from_string(input)
        toboggan_ride = TobogganRide.new(grid: grid)
        toboggan_ride.number_of_trees
      end

      def part_two(input)
        grid = Grid.from_string(input)
        slopes = [
          OpenStruct.new(right: 1, down: 1),
          OpenStruct.new(right: 3, down: 1),
          OpenStruct.new(right: 5, down: 1),
          OpenStruct.new(right: 7, down: 1),
          OpenStruct.new(right: 1, down: 2)
        ]

        slopes.map do |slope|
          TobogganRide.new(grid: grid, slope: slope).number_of_trees
        end.reduce(:*)
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

      def next_position(slope:, x:, y:)
        new_x = x + slope.down

        return unless new_x < height

        {
          x: new_x,
          y: (y + slope.right) % width
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
      def initialize(grid:, slope: default_slope)
        @grid = grid
        @slope = slope
      end

      def number_of_trees
        path.count(&:tree?)
      end

      private

      attr_reader :grid,
                  :slope

      def path
        @path ||= calculate_path
      end

      def default_slope
        OpenStruct.new(right: 3, down: 1)
      end

      def calculate_path
        initial_position = { x: 0, y: 0 }
        position = initial_position

        result = []

        while position
          result.push(grid.at(position))
          position = grid.next_position(slope: slope, **position)
        end

        result
      end
    end
  end
end
