# frozen_string_literal: true

module Aoc2020
  module DayOne
    class << self
      def part_one(input)
        numbers = input.chomp.split("\n").map(&method(:Integer))

        first, second = numbers.combination(2).find do |(x, y)|
          x + y == 2020
        end

        first * second
      end
    end
  end
end
