module Aoc2020
  module DayFour
    class << self
      def part_one(input)
        input.chomp.split("\n\n").count do |line|
          valid?(line)
        end
      end

      def part_two(input)
        input.chomp.split("\n\n").count do |line|
          actually_valid?(line)
        end
      end

      def valid?(line)
        %w[
          byr
          iyr
          eyr
          hgt
          hcl
          ecl
          pid
        ].all? { |field| line.include?("#{field}:") }
      end

      def actually_valid?(line)
        data = line.split(' ')
        fields = data.reduce({}) do |memo, d|
          name, value = d.split(':')
          memo.merge(name => value)
        end

        valid_birth_year?(fields['byr']) &&
          valid_issue_year?(fields['iyr']) &&
          valid_expiration_year?(fields['eyr']) &&
          valid_height?(fields['hgt']) &&
          valid_hair_color?(fields['hcl']) &&
          valid_eye_color?(fields['ecl']) &&
          valid_pid?(fields['pid'])
      end

      def valid_birth_year?(value)
        return false if value.nil?

        (1920..2002).cover? Integer(value)
      end

      def valid_issue_year?(value)
        return false if value.nil?

        (2010..2020).cover? Integer(value)
      end

      def valid_expiration_year?(value)
        return false if value.nil?

        (2020..2030).cover? Integer(value)
      end

      def valid_height?(string)
        return false if string.nil?

        case string[-2..]
        when 'cm'
          value = Integer(string[0..-3])
          value >= 150 && value <= 193
        when 'in'
          value = Integer(string[0..-3])
          value >= 59 && value <= 76
        else
          false
        end
      end

      def valid_eye_color?(value)
        return false if value.nil?

        %w[amb blu brn gry grn brn hzl oth].include?(value)
      end

      def valid_hair_color?(value)
        return false if value.nil?

        value.match?(/\A\#[0-9a-f]{6}\z/)
      end

      def valid_pid?(value)
        return false if value.nil?

        value.match?(/\A\d{9}\z/)
      end
    end
  end
end
