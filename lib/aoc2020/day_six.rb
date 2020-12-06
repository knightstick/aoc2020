require 'set'

module Aoc2020
  module DaySix
    class << self
      def part_one(input)
        input.chomp.split("\n\n").map do |group|
          anyone(group)
        end.sum
      end

      def part_two(input)
        input.chomp.split("\n\n").map do |group|
          everyone(group)
        end.sum
      end

      def anyone(group)
        group.gsub("\n", '').chars.sort.uniq.count
      end

      def everyone(group)
        each_person = group.chomp.split("\n").map do |line|
          line.chars.reduce(Set.new) do |acc, char|
            acc.add(char)
          end
        end

        base = each_person.first
        others = each_person[1..]

        if others.any?
          others.reduce(base) do |acc, set|
            acc.intersection(set)
          end.size
        else
          base.size
        end
      end
    end
  end
end
