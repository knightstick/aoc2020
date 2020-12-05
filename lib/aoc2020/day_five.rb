module Aoc2020
  module DayFive
    class << self
      def part_one(input)
        seat_ids(input).max
      end

      def part_two(input)
        seats = seat_ids(input).sort
        to_the_left = seats.each.with_index.find do |id, index|
          seats[index + 1] == (id + 2)
        end[0]

        to_the_left + 1
      end

      def party_one(input)
        binaries(input).map { |b| b.to_i(2) }.max
      end

      def binaries(input)
        input.chomp.split("\n").map do |seat|
          seat.gsub('B', '1').gsub('F', '0').gsub('R', '1').gsub('L', '0')
        end
      end

      def seat_ids(input)
        input.chomp.split("\n").lazy.map do |seats|
          seat_number(seats)
        end
      end

      def seat_number(input)
        (row(input[0..6]) * 8) + column(input[7..])
      end

      def row(string)
        binary_partition(string)
      end

      def binary_partition(string, bottom: 'F', top: 'B', initial_min: 0, initial_max: 127)
        min, max = string.chars.reduce([initial_min, initial_max]) do |(min, max), letter|
          case letter
          when bottom
            [min, midpoint(min, max)]
          when top
            [midpoint(min, max) + 1, max]
          else
            raise 'Unknown letter'
          end
        end

        raise unless min == max

        min
      end

      def column(string)
        binary_partition(string, bottom: 'L', top: 'R', initial_min: 0, initial_max: 7)
      end

      def midpoint(min, max)
        (min + max) / 2
      end
    end
  end
end
