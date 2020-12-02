# frozen_string_literal: true

require 'scanf'

module Aoc2020
  module DayTwo
    class << self
      def part_one(input)
        policies_and_passwords(input).count do |policy, password|
          PasswordValidator.new(policy: policy, password: password).valid?
        end
      end

      def part_two(input)
        policies_and_passwords(input).count do |policy, password|
          PasswordValidatorV2.new(policy: policy, password: password).valid?
        end
      end

      def party_one(input)
        input.chomp.split("\n").count do |line|
          min, max, char, password = line.scanf('%d-%d %c: %s')
          policy = Policy.new(min: min, max: max, char: char)
          policy.valid?(password)
        end
      end

      def party_two(input)
        input.chomp.split("\n").count do |line|
          first, second, char, password = line.scanf('%d-%d %c: %s')
          policy = PolicyV2.new(first: first - 1, second: second - 1, char: char)
          policy.valid?(password)
        end
      end

      private

      def policies_and_passwords(input)
        input.chomp.split("\n").map { |line| line.split(': ') }
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
        (min..max).cover?(password.count(char))
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
        password[first] == char
      end

      def second?(password)
        password[second] == char
      end
    end
  end
end
