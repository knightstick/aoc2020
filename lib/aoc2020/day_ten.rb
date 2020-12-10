require 'pry'

module Aoc2020
  module DayTen
    class << self
      def part_one(input)
        numbers = input.chomp.split("\n").map(&method(:Integer)).sort

        diffs = [numbers[0]]

        (1...numbers.length).each do |index|
          raise "Nil #{index}" if numbers[index].nil?
          raise "Nil in -1 #{index}" if numbers[index - 1].nil?

          diffs << numbers[index] - numbers[index - 1]
        end

        diffs.count { |d| d == 1 } * (diffs.count { |d| d == 3 } + 1)
      end

      def part_two(input)
        numbers = input.chomp.split("\n").map(&method(:Integer)).sort

        full_numbers = [0] + numbers + [numbers.max + 3]

        can_see = full_numbers.each.with_index.reduce({}) do |acc, (n, idx)|
          neighbours = full_numbers[idx + 1..].select { |other| other - n <= 3 }
          acc.merge(n => neighbours)
        end

        number_of_ways(can_see)
      end

      def number_of_ways(can_see, here: 0, acc: 0, memo: {})
        return memo[here] unless memo[here].nil?

        return acc + 1 if here == can_see.keys.max

        can_see[here].reduce(0) do |total, to_go|
          memo[to_go] = number_of_ways(can_see, here: to_go, acc: acc, memo: memo)
          total + memo[to_go]
        end
      end
    end
  end
end
