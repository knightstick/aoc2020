module Aoc2020
  module DayEighteen
    class << self
      def part_one(input)
        input.chomp.split("\n").map(&method(:calculate_line)).sum
      end

      def part_two(input)
        input.chomp.split("\n").map(&method(:calculate_advanced_line)).sum
      end

      def calculate_line(line)
        return simplify_and_calculate(line) if line.include?('(')

        line.match(/(\d+)\s+([+*])\s+(\d+)(.*)/) do |m|
          int1 = Integer(m[1])
          int2 = Integer(m[3])
          op = m[2]

          case op
          when '+'
            sum = int1 + int2
            return calculate_line("#{sum} #{m[4]}")
          when '*'
            product = int1 * int2
            return calculate_line("#{product} #{m[4]}")
          else
            raise "Unknown operator #{op.inspect}"
          end
        end

        Integer(line.match(/\d+/)[0])
      end

      def calculate_advanced_line(line)
        return simplify_and_calculate_advanced(line) if line.include?('(')
        return do_addition_and_calculate(line) if line.include?('+')

        line.match(/(\d+)\s+\*\s+(\d+)(.*)/) do |m|
          product = Integer(m[1]) * Integer(m[2])
          return calculate_line("#{product} #{m[3]}")
        end

        Integer(line.match(/\d+/)[0])
      end

      def simplify_and_calculate(line)
        simplify_and_yield(line, &method(:calculate_line))
      end

      def simplify_and_calculate_advanced(line)
        simplify_and_yield(line, &method(:calculate_advanced_line))
      end

      def do_addition_and_calculate(line)
        m = line.strip.match(/(.*\d+\s+\*\s+)?(\d+\s+\+)\s+(\d+\s?)(.*)/)
        prefix = m[1] || ''
        int1 = m[2].to_i
        int2 = m[3].to_i
        suffix = m[4] || ''

        new_line = "#{prefix} #{int1 + int2} #{suffix}"

        calculate_advanced_line(new_line.strip)
      end

      def simplify_and_yield(line)
        first, paren_bit = line.split('(', 2)
        paren_count = 1

        last_paren_index = paren_bit.chars.each.with_index do |char, index|
          case char
          when ')'
            paren_count -= 1
            break index if paren_count.zero?
          when '('
            paren_count += 1
            next
          else
            next
          end
        end

        inner = yield paren_bit[0...last_paren_index]
        rest = paren_bit[last_paren_index + 1..]

        yield "#{first} #{inner} #{rest}"
      end
    end
  end
end
