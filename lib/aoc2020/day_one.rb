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

      def party_one(input)
        find_two(input.chomp.split)
      end

      def party_two(input)
        find_three(input.chomp.split)
      end

      private

      def numbers(input)
        input.chomp.split("\n").map(&method(:Integer))
      end

      def find_two(strings, target = 2020)
        strings.lazy.with_index.map do |string, index|
          number = Integer(string)
          inner_target = target - number
          second = strings[index + 1..].lazy.map(&method(:Integer)).find { |elem| elem == inner_target }

          number * second if second
        end.find(&:itself)
      end

      def find_three(strings, target = 2020)
        strings.lazy.with_index.map do |string, index|
          number = Integer(string)
          inner_target = target - number
          two_product = find_two(strings[index + 1..], inner_target)
          two_product * number if two_product
        end.find(&:itself)
      end
    end
  end
end
