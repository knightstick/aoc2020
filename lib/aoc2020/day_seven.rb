require 'pry'

module Aoc2020
  module DaySeven
    class << self
      def part_one(input)
        rules = bag_rules(input.chomp.split("\n"))
        # Don't count 'shiny gold' itself
        rules.values.count { |rule| rule == true } - 1
      end

      def part_two(input)
        counts(input.chomp.split("\n"))['shiny gold']
      end

      def bag_rules(lines)
        remaining_lines = lines
        includes_gold = {}

        while remaining_lines.any?
          end_line = remaining_lines.find { |l| l.include? 'no other bags' }

          if end_line
            description = description(end_line)
            includes_gold[description] = (description == 'shiny gold')
            remaining_lines -= [end_line]
          else
            can_do_line = remaining_lines.find do |line|
              content_descriptions(line).all? do |desc|
                !includes_gold[desc].nil?
              end
            end
            raise unless can_do_line

            description = description(can_do_line)
            includes_gold[description] = (description == 'shiny gold') ||
                                         content_descriptions(can_do_line).any? do |desc|
                                           includes_gold[desc] == true
                                         end

            remaining_lines -= [can_do_line]
          end
        end

        includes_gold
      end

      def counts(lines)
        remaining_lines = lines
        bag_counts = {}

        while remaining_lines.any?
          end_line = remaining_lines.find { |l| l.include? 'no other bags' }

          if end_line
            description = description(end_line)
            bag_counts[description] = 0
            remaining_lines -= [end_line]
          else
            can_do_line = remaining_lines.find do |line|
              content_descriptions(line).all? do |desc|
                !bag_counts[desc].nil?
              end
            end
            raise unless can_do_line

            description = description(can_do_line)
            inner_bags = content_descriptions(can_do_line)
            bag_counts[description] = inner_bags.size + inner_bags.map do |desc|
              bag_counts[desc]
            end.sum

            remaining_lines -= [can_do_line]
          end
        end

        bag_counts
      end

      def description(line)
        description, _contents = line.split(' bags contain ')
        description
      end

      def content_descriptions(line)
        _description, contents = line.split(' bags contain ')

        contents.split(', ').flat_map do |content|
          a, adj, color, _bag = content.split(' ')
          desc = [adj, color].join(' ')
          Array.new(Integer(a)) { desc }
        end
      end
    end
  end
end
