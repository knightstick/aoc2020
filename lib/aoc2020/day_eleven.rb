require 'pry'

module Aoc2020
  module DayEleven
    class << self
      def part_one(input)
        end_up_occupied(grid(input))
      end

      def part_two(input)
        end_up_occupied(grid(input), :new_state_visible)
      end

      def grid(input)
        input.chomp.split("\n").each.with_index.reduce({}) do |grid_acc, (line, i)|
          line.chars.each.with_index.reduce(grid_acc) do |inner_acc, (char, j)|
            inner_acc.merge([i, j] => seat_from_char(char))
          end
        end
      end

      def seat_from_char(char)
        case char
        when 'L'
          :empty
        when '.'
          :floor
        when '#'
          :occupied
        else
          raise "Unknown char: #{char}"
        end
      end

      def end_up_occupied(grid, state_method = :new_state)
        new_grid, changed = step(grid, state_method)

        return end_up_occupied(new_grid, state_method) if changed

        new_grid.count do |_point, value|
          value == :occupied
        end
      end

      def step(grid, new_state_method = :new_state)
        grid.reduce([{}, false]) do |(grid_acc, changed), ((x, y), value)|
          new_value = send(new_state_method, [x, y], grid)
          new_changed = changed || (value != new_value)
          [grid_acc.merge([x, y] => new_value), new_changed]
        end
      end

      def neighbour_points(point)
        x, y = point
        [
          [x - 1, y],
          [x + 1, y],
          [x, y - 1],
          [x, y + 1],
          [x - 1, y - 1],
          [x - 1, y + 1],
          [x + 1, y - 1],
          [x + 1, y + 1]
        ]
      end

      def new_state(point, grid)
        value = grid[point]
        return value if value == :floor

        return :occupied if value == :empty && no_occupied_neighbours?(point, grid)

        return :empty if value == :occupied && too_many_occupied_neighbours?(point, grid)

        value
      end

      def new_state_visible(point, grid)
        value = grid[point]
        return value if value == :floor

        return :occupied if value == :empty && no_visible_occupied_neighbours?(point, grid)

        return :empty if value == :occupied && too_many_visible_occupied_neighbours?(point, grid)

        value
      end

      def no_occupied_neighbours?(point, grid)
        neighbour_points(point).none? { |pt| grid[pt] == :occupied }
      end

      def all_direction_vectors
        [
          [-1, -1], [-1, 0], [-1, 1],
          [0, -1], [0, 1],
          [1, -1], [1, 0], [1, 1]
        ]
      end

      def no_visible_occupied_neighbours?(point, grid)
        all_direction_vectors.each do |vector|
          neighbour = visible_in_direction(point, grid, vector)
          return false if neighbour == :occupied
        end
        true
      end

      def too_many_occupied_neighbours?(point, grid)
        occupied = 0
        neighbour_points(point).each do |pt|
          neighbour = grid[pt]
          occupied += 1 if neighbour == :occupied
          return true if occupied >= 4
        end
        false
      end

      def too_many_visible_occupied_neighbours?(point, grid)
        occupied = 0
        all_direction_vectors.each do |vector|
          neighbour = visible_in_direction(point, grid, vector)
          occupied += 1 if neighbour == :occupied
          return true if occupied >= 5
        end
        false
      end

      def print_grid(grid)
        max_x = grid.keys.max { |(x, _y), _value| x }[0]
        max_y = grid.keys.max { |(_x, y), _value| y }[1]

        print "\n"
        (0..max_x).each do |x|
          puts (0..max_y).map { |y| square_char(grid[[x, y]]) }.join('')
        end
      end

      def square_char(square)
        case square
        when :empty
          'L'
        when :occupied
          '#'
        when :floor
          '.'
        else
          raise "Unknown square #{square}"
        end
      end

      def visible_in_direction(point, grid, vector)
        x, y = point
        diff_x, diff_y = vector

        next_point = [x + diff_x, y + diff_y]
        next_value = grid[next_point]

        return visible_in_direction(next_point, grid, vector) if next_value == :floor

        next_value
      end
    end
  end
end
