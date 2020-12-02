# frozen_string_literal: true

module Aoc2020
  module DayTwo
    class << self
      def part_one(input)
        policies_and_passwords(input).map do |policy, password|
          PasswordValidator.new(policy: policy, password: password)
        end.count(&:valid?)
      end

      def part_two(input)
        policies_and_passwords(input).map do |policy, password|
          PasswordValidatorV2.new(policy: policy, password: password)
        end.count(&:valid?)
      end

      private

      def policies_and_passwords(input)
        input.chomp.split("\n").map do |line|
          line.split(': ')
        end
      end
    end

    class PasswordValidator
      def initialize(policy:, password:)
        @policy = parse_policy(policy)
        @password = password
      end

      def valid?
        policy.valid?(password)
      end

      private

      attr_reader :policy,
                  :password

      def parse_policy(string)
        min_max, char = string.split(' ')
        min, max = min_max.split('-')

        Policy.new(min: Integer(min), max: Integer(max), char: char)
      end
    end

    class PasswordValidatorV2
      def initialize(policy:, password:)
        @policy = parse_policy(policy)
        @password = password
      end

      def valid?
        policy.valid?(password)
      end

      private

      attr_reader :policy,
                  :password

      def parse_policy(string)
        indices, char = string.split(' ')
        first, second = indices.split('-')

        PolicyV2.new(first: Integer(first) - 1, second: Integer(second) - 1, char: char)
      end
    end

    class Policy
      def initialize(min:, max:, char:)
        @min = min
        @max = max
        @char = char
      end

      def valid?(password)
        occurrences = password.chars.count { |elem| elem == char }
        (min..max).cover?(occurrences)
      end

      private

      attr_reader :min,
                  :max,
                  :char
    end

    class PolicyV2
      def initialize(first:, second:, char:)
        @first = first
        @second = second
        @char = char
      end

      def valid?(password)
        first?(password) ^ second?(password)
      end

      private

      attr_reader :first,
                  :second,
                  :char

      def first?(password)
        in_position?(first, password)
      end

      def second?(password)
        in_position?(second, password)
      end

      def in_position?(position, password)
        password[position] == char
      end
    end
  end
end
