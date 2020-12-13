# frozen_string_literal: true

module Aoc2020
  module DayThirteen
    class << self
      def part_one(input)
        first_timestring, buses_notes = input.chomp.split("\n")
        first_timestamp = Integer(first_timestring)
        bus_ids = bus_ids(buses_notes)

        id, bus_arrives = (first_timestamp..first_timestamp + bus_ids.max).each do |timestamp|
          id = bus_ids.find { |bid| (timestamp % bid).zero? }
          break [id, timestamp] unless id.nil?
        end

        mins_to_wait = bus_arrives - first_timestamp

        id * mins_to_wait
      end

      def part_two(input)
        _, notes = input.chomp.split("\n")

        constraints = []
        notes.split(',').each.with_index do |note, mod|
          unless note == 'x'
            n = Integer(note)
            constraints << [n, (-1 * mod) % n]
          end
        end

        _big_n, a12 = solve_congruences(constraints)

        a12
      end

      def bus_ids(notes)
        notes.split(',').map do |note|
          Integer(note)
        rescue StandardError
          nil
        end.compact
      end

      def extended_euclid(a, b)
        old_r = a
        r = b
        old_s = 1
        s = 0
        old_t = 0
        t = 1

        while r != 0
          quotient = old_r / r
          old_r, r = [r, old_r - quotient * r]
          old_s, s = [s, old_s - quotient * s]
          old_t, t = [t, old_t - quotient * t]
        end

        [old_s, old_t]
      end

      def solve_congruence(pair1, pair2)
        n1, a1 = pair1
        n2, a2 = pair2
        m1, m2 = extended_euclid(n1, n2)
        a12 = (a1 * m2 * n2) + (a2 * m1 * n1)
        big_n = n1 * n2

        [big_n, a12 % big_n]
      end

      def solve_congruences(congruences)
        return congruences[0] if congruences.length < 2

        big_n, a12 = solve_congruence(congruences[0], congruences[1])

        solve_congruences([[big_n, a12]] + congruences[2..])
      end
    end
  end
end
