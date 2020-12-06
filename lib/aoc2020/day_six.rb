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

      def party_one(input)
        input.chomp.split("\n\n").map do |lines|
          AnswerGroup.from_lines(lines).anyone_answered.length
        end.sum
      end

      def party_two(input)
        input.chomp.split("\n\n").map do |lines|
          AnswerGroup.from_lines(lines).everyone_answered.length
        end.sum
      end

      def partz_one(input)
        input.chomp.split("\n\n").map do |lines|
          lines
            .split("\n")
            .lazy.map { |line| Set.new(line.chars) }
            .reduce do |acc, set|
            acc.union(set)
          end.size
        end.sum
      end

      def partz_two(input)
        input.chomp.split("\n\n").map do |lines|
          lines
            .split("\n")
            .lazy.map { |line| Set.new(line.chars) }
            .reduce do |acc, set|
            acc.intersection(set)
          end.size
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

    class AnswerGroup
      class << self
        def from_lines(lines)
          person_answers = lines.split("\n").map do |line|
            PersonAnswers.from_line(line)
          end

          new(person_answers: person_answers)
        end
      end

      def initialize(person_answers:)
        @person_answers = person_answers
      end

      def anyone_answered
        person_answers.reduce do |memo, person_answer|
          memo.union(person_answer)
        end.answers
      end

      def everyone_answered
        person_answers.reduce do |memo, person_answer|
          memo.intersection(person_answer)
        end.answers
      end

      private

      attr_reader :person_answers
    end

    class PersonAnswers
      include Enumerable

      class << self
        def from_line(line)
          answers = line.chars.reduce(Set.new) do |acc, answer|
            acc.add(answer)
          end

          new(answers: answers)
        end
      end

      def initialize(answers:)
        @answers = answers
      end

      def each(*args, &block)
        answers.each(*args, &block)
      end

      def union(other_answers)
        PersonAnswers.new(answers: answers.union(other_answers.answers))
      end

      def intersection(other_answers)
        PersonAnswers.new(answers: answers.intersection(other_answers.answers))
      end

      attr_reader :answers
    end
  end
end
