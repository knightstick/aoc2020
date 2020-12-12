module Aoc2020
  module DayTwelve
    class << self
      def part_one(input)
        instructions = input.chomp.split("\n").map do |line|
          instruction(line)
        end

        ship = Ship.new

        instructions.each do |instruction|
          ship.move(**instruction)
        end

        ship.manhattan_distance
      end

      def part_two(input)
        instructions = input.chomp.split("\n").map do |line|
          instruction(line)
        end

        ship = WaypointShip.new

        instructions.each do |instruction|
          ship.move(**instruction)
        end

        ship.manhattan_distance
      end

      def instruction(line)
        action, value = line.scanf('%c%d')
        {
          action: action,
          value: Integer(value)
        }
      end
    end

    class Ship
      def initialize
        @heading = 90 # East
        @position = [0, 0]
      end

      def move(action:, value:)
        case action
        when 'N'
          north(value)
        when 'S'
          south(value)
        when 'E'
          east(value)
        when 'W'
          west(value)
        when 'L'
          left(value)
        when 'R'
          right(value)
        when 'F'
          forward(value)
        else
          raise "Unknown action #{action}"
        end
      end

      attr_reader :position,
                  :heading

      def manhattan_distance
        x, y = position
        x.abs + y.abs
      end

      private

      attr_writer :position,
                  :heading

      def north(value)
        x, y = position
        self.position = [x, y + value]
      end

      def south(value)
        x, y = position
        self.position = [x, y - value]
      end

      def east(value)
        x, y = position
        self.position = [x + value, y]
      end

      def west(value)
        x, y = position
        self.position = [x - value, y]
      end

      def left(value)
        self.heading = (heading - value) % 360
      end

      def right(value)
        self.heading = (heading + value) % 360
      end

      def forward(value)
        case heading
        when 0
          north(value)
        when 90
          east(value)
        when 180
          south(value)
        when 270
          west(value)
        else
          raise "Unknown heading #{heading}"
        end
      end
    end

    class WaypointShip
      def initialize
        @position = [0, 0]
        @waypoint = [10, 1]
      end

      def move(action:, value:)
        case action
        when 'N'
          north(value)
        when 'S'
          south(value)
        when 'E'
          east(value)
        when 'W'
          west(value)
        when 'L'
          left(value)
        when 'R'
          right(value)
        when 'F'
          forward(value)
        else
          raise "Unknown action #{action}"
        end
      end

      attr_accessor :position,
                    :waypoint

      def manhattan_distance
        x, y = position
        x.abs + y.abs
      end

      def north(value)
        x, y = waypoint
        self.waypoint = [x, y + value]
      end

      def south(value)
        x, y = waypoint
        self.waypoint = [x, y - value]
      end

      def east(value)
        x, y = waypoint
        self.waypoint = [x + value, y]
      end

      def west(value)
        x, y = waypoint
        self.waypoint = [x - value, y]
      end

      def left(value)
        right(360 - value)
      end

      def right(value)
        x, y = waypoint

        case value
        when 90
          self.waypoint = [y, -x]
        when 180
          self.waypoint = [-x, -y]
        when 270
          self.waypoint = [-y, x]
        when 360
          self.waypoint = waypoint
        else
          raise "Unknown rotation #{value}"
        end
      end

      def forward(value)
        waypoint_x, waypoint_y = waypoint
        ship_x, ship_y = position

        self.position = [ship_x + value * waypoint_x, ship_y + value * waypoint_y]
      end
    end
  end
end
