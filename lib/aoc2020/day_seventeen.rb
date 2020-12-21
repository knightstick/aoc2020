module Aoc2020
  module DaySeventeen
    class << self
      def part_one(input, n = 6)
        dimension = Dimension.from_plane(plane(input))

        n.times { dimension.cycle! }

        dimension.active_cubes_count
      end

      def part_two(input, n = 6)
        dimension = MoarDimension.from_plane(plane(input))

        n.times { dimension.cycle! }

        dimension.active_cubes_count
      end

      def plane(input)
        input.chomp.split("\n").map do |line|
          line.chars.map do |char|
            cube_from_char(char)
          end
        end
      end

      def cube_from_char(char)
        case char
        when '.'
          :inactive
        when '#'
          :active
        else
          raise "Unknown cube type #{char.inspect}"
        end
      end
    end

    class Dimension
      class << self
        def from_plane(plane)
          dimension = new
          plane.each.with_index do |line, x|
            line.each.with_index do |cube, y|
              dimension.set_cube(x, y, 0, cube)
            end
          end

          dimension
        end
      end

      def initialize
        @points = {}
      end

      def set_cube(x, y, z, state)
        points[[x, y, z]] = state
      end

      def get_cube(x, y, z)
        points[[x, y, z]]
      end

      def zipped_coords
        point_coords.first.zip(*point_coords[1..])
      end

      def point_coords
        points.keys
      end

      def neighbours(x, y, z)
        [-1, 0, 1].repeated_permutation(3).map do |x_diff, y_diff, z_diff|
          next if x_diff.zero? && y_diff.zero? && z_diff.zero?

          new_x = x + x_diff
          new_y = y + y_diff
          new_z = z + z_diff
          [[new_x, new_y, new_z], get_cube(new_x, new_y, new_z)]
        end
      end

      def neighbour_states(x, y, z)
        neighbours(x, y, z).map { |_point, state| state }
      end

      def cycle!
        xs, ys, zs = zipped_coords

        new_points = {}
        (xs.min - 1..xs.max + 1).each do |x|
          (ys.min - 1..ys.max + 1).each do |y|
            (zs.min - 1..zs.max + 1).each do |z|
              new_points[[x, y, z]] = next_state(x, y, z)
            end
          end
        end

        self.points = new_points
      end

      def next_state(x, y, z)
        state = get_cube(x, y, z)
        neighbours = neighbour_states(x, y, z)
        active_neighbours = neighbours.count { |state| state == :active }

        if state == :active
          if [2, 3].include?(active_neighbours)
            :active
          else
            :inactive
          end
        else
          if active_neighbours == 3
            :active
          else
            :inactive
          end
        end
      end

      def active_cubes_count
        points.flatten.select { |cube| cube == :active }.count
      end

      def to_s
        xs, ys, zs = zipped_coords

        (zs.min..zs.max).map do |z|
          plane = (xs.min..xs.max).map do |x|
            (ys.min..ys.max).map do |y|
              cube = get_cube(x, y, z)
              cube == :active ? '#' : '.'
            end.join('')
          end.join("\n")

          "z=#{z}\n#{plane}\n\n"
        end.join("\n\n")
      end

      attr_accessor :points
    end

    class MoarDimension
      class << self
        def from_plane(plane)
          dimension = new
          plane.each.with_index do |line, x|
            line.each.with_index do |cube, y|
              dimension.set_cube(x, y, 0, 0, cube)
            end
          end

          dimension
        end
      end

      def initialize
        @points = {}
      end

      def set_cube(x, y, z, w, state)
        points[[x, y, z, w]] = state
      end

      def get_cube(x, y, z, w)
        points[[x, y, z, w]]
      end

      def zipped_coords
        point_coords.first.zip(*point_coords[1..])
      end

      def point_coords
        points.keys
      end

      def neighbours(x, y, z, w)
        [-1, 0, 1].repeated_permutation(4).map do |x_diff, y_diff, z_diff, w_diff|
          next if x_diff.zero? && y_diff.zero? && z_diff.zero? && w_diff.zero?

          new_x = x + x_diff
          new_y = y + y_diff
          new_z = z + z_diff
          new_w = w + w_diff
          [[new_x, new_y, new_z, new_w], get_cube(new_x, new_y, new_z, new_w)]
        end
      end

      def neighbour_states(x, y, z, w)
        neighbours(x, y, z, w).map { |_point, state| state }
      end

      def cycle!
        xs, ys, zs, ws = zipped_coords

        new_points = {}
        (xs.min - 1..xs.max + 1).each do |x|
          (ys.min - 1..ys.max + 1).each do |y|
            (zs.min - 1..zs.max + 1).each do |z|
              (ws.min - 1..ws.max + 1).each do |w|
                new_points[[x, y, z, w]] = next_state(x, y, z, w)
              end
            end
          end
        end

        self.points = new_points
      end

      def next_state(x, y, z, w)
        state = get_cube(x, y, z, w)
        neighbours = neighbour_states(x, y, z, w)
        active_neighbours = neighbours.count { |state| state == :active }

        if state == :active
          if [2, 3].include?(active_neighbours)
            :active
          else
            :inactive
          end
        else
          if active_neighbours == 3
            :active
          else
            :inactive
          end
        end
      end

      def active_cubes_count
        points.flatten.select { |cube| cube == :active }.count
      end

      # def to_s
      #   xs, ys, zs = zipped_coords

      #   (zs.min..zs.max).map do |z|
      #     plane = (xs.min..xs.max).map do |x|
      #       (ys.min..ys.max).map do |y|
      #         cube = get_cube(x, y, z)
      #         cube == :active ? '#' : '.'
      #       end.join('')
      #     end.join("\n")

      #     "z=#{z}\n#{plane}\n\n"
      #   end.join("\n\n")
      # end

      attr_accessor :points
    end
  end
end
