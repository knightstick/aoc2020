# frozen_string_literal: true

module Aoc2020
  module DayOne
    class << self
      def part_one(input)
        first, second = numbers(input).combination(2).find { |x, y| x + y == 2020 }
        first * second
      end

      def part_two(input)
        first, second, third = numbers(input).combination(3).find do |(x, y, z)|
          x + y + z == 2020
        end

        first * second * third
      end

      def part_n(input, take, total)
        numbers(input).combination(take).find { |list| list.sum == total }&.reduce(:*)
      end

      private

      def numbers(input)
        input.chomp.split("\n").map(&method(:Integer))
      end
    end
  end
end
