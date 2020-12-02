# frozen_string_literal: true

module Aoc2020
  module DayTwo
    class << self
      def part_one(input)
        policies_and_passwords = input.chomp.split("\n").map do |line|
          line.split(': ')
        end

        policies_and_passwords.map do |policy, password|
          PasswordValidator.new(policy: policy, password: password)
        end.count(&:valid?)
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
  end
end
