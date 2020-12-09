module Aoc2020
  module DayNine
    class << self
      def part_one(input, preamble_size = 25)
        numbers = input.chomp.split("\n").map(&method(:Integer))

        index = (0...numbers.length - preamble_size).find do |idx|
          number = numbers[idx + preamble_size]
          in_range = numbers[idx...idx + preamble_size]
          !can_sum(number, in_range)
        end

        numbers[index + preamble_size]
      end

      def part_two(input, preamble_size = 25)
        target = part_one(input, preamble_size)
        numbers = input.chomp.split("\n").map(&method(:Integer))
        list = find_contiguous_list(target, numbers)

        list.min + list.max
      end

      private

      def can_sum(target, range)
        range.any? do |x|
          range.include? target - x
        end
      end

      def find_contiguous_list(target, numbers)
        (0..numbers.length).lazy.map do |idx|
          list_from_n(target, numbers[idx..])
        end.find(&:itself)
      end

      def list_from_n(target, numbers, acc = [])
        head = numbers[0]
        if target == head
          acc + [head]
        elsif target > head
          list_from_n(target - head, numbers[1..], acc + [head])
        end
      end
    end
  end
end
