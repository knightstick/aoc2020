module Aoc2020
  module DayTwentyThree
    class << self
      def part_one(input, moves = 100)
        cups = input.chomp.chars.map(&method(:Integer))

        game = CupGame.new(cups, moves)
        # puts "\n"
        game.play
        game.labels_after_one.join('')
      end

      def part_two(input, moves = 10_000_000)
        cups = input.chomp.chars.map(&method(:Integer))
        cups += (6..1_000_000).to_a
        game = CupGame.new(cups, moves)
        game.play
        first_star, second_star = game.labels_after_one(2)
        first_star * second_star
      end
    end

    class CupGame
      def initialize(cups, max_moves = 10)
        @cups = CupRing.new(cups)
        @move = 1
        @max_moves = max_moves
      end

      attr_reader :cups

      attr_accessor :move,
                    :max_moves

      def play
        return final if move > max_moves

        # puts "Move #{move}" if move % 10 == 0

        current = cups.current_cup
        three = take_three_after_current
        destination = cups.destination(current)
        # puts "destination: #{destination}"

        place_after_destination(three, current, destination)
        rotate_current_cup

        self.move += 1
        # puts "\n"
        play
      end

      def to_s
        <<~GAME
          -- move #{move} --
          cups: #{cups}
        GAME
      end

      def take_three_after_current
        cups.take_three_after_current.tap do |three|
          # puts "pick up: #{three.join(', ')}"
        end
      end

      def place_after_destination(moved_cups, current, destination)
        cups.place_after_destination(moved_cups, current, destination)
      end

      def rotate_current_cup
        cups.rotate_current_cup
      end

      def final
        # puts <<~FINAL
        #   -- final --
        #   cups: #{cups}
        # FINAL
      end

      def labels_after_one
        cups.labels_after_one
      end
    end

    class CupRing
      def initialize(cups)
        @cups = cups
        @current_cup_index = 0
      end

      attr_accessor :cups,
                    :current_cup_index

      def to_s
        cups.map.with_index do |cup, index|
          index == current_cup_index ? "(#{cup})" : cup.to_s
        end.join(' ')
      end

      def current_cup
        cups[current_cup_index]
      end

      def take_three_after_current
        cups.cycle(2).to_a[current_cup_index + 1..current_cup_index + 3].tap do |three|
          self.cups = cups - three
        end
      end

      def destination(current)
        label = current - 1
        return label if cups.include?(label)
        return cups.max if label < cups.min

        destination(label)
      end

      def place_after_destination(cups_to_place, current_value, destination_value)
        destination_index = cups.index(destination_value)

        new_cups = cups[0..destination_index] + cups_to_place + cups[destination_index + 1..]

        cups.replace(new_cups.rotate(new_cups.index(current_value) - current_cup_index))
      end

      def rotate_current_cup
        self.current_cup_index = (current_cup_index + 1) % cups.length
      end

      def labels_after_one(n = cups.length - 1)
        one_index = cups.index(1)
        cups.cycle(2).to_a[one_index + 1..one_index + n]
      end
    end
  end
end
