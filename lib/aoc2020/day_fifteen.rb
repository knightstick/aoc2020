module Aoc2020
  module DayFifteen
    class << self
      def part_one(input, n = 2020)
        starting_numbers = input.chomp.split(',').map(&method(:Integer))

        said_numbers = {}
        (1..n).reduce(nil) do |last_number, turn|
          # Turns are 1-indexed
          next_number = if turn < starting_numbers.length + 1
                          starting_numbers[turn - 1]
                        elsif said_numbers.key? last_number
                          last_turn = turn - 1
                          prev_said = said_numbers[last_number]
                          last_turn - prev_said
                        else
                          0
                        end

          said_numbers[last_number] = turn - 1 if last_number

          next_number
        end
      end

      def part_two(input)
        part_one(input, 30_000_000)
      end
    end
  end
end
