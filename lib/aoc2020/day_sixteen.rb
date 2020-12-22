module Aoc2020
  module DaySixteen
    class << self
      def part_one(input)
        document = parse_document(input)
        scanner = TicketScanner.new(rules: document.rules, tickets: document.nearby_tickets)

        scanner.error_rate
      end

      def part_two(input)
        document = parse_document(input)
        scanner = TicketScanner.new(rules: document.rules, tickets: document.nearby_tickets)

        scanner.departure_values(document.my_ticket).reduce(&:*)
      end

      def parse_document(input)
        rule_string, my_ticket_string, nearby_ticket_string = input.chomp.split("\n\n")

        rules = rule_string.split("\n").map(&method(:parse_rule))
        nearby_tickets = nearby_ticket_string.split("\n").drop(1).map(&method(:parse_ticket))
        my_ticket = parse_ticket(my_ticket_string.split("\n").drop(1).first)

        OpenStruct.new(
          rules: rules,
          nearby_tickets: nearby_tickets,
          my_ticket: my_ticket
        )
      end

      def parse_rule(line)
        Rule.parse(line)
      end

      def parse_ticket(line)
        line.split(',').map(&method(:Integer))
      end
    end

    class Rule
      class << self
        def parse(line)
          name, rules = line.split(': ')
          lower_range, upper_range = rules.split(' or ')

          lower_lower, lower_upper = lower_range.split('-')
          upper_lower, upper_upper = upper_range.split('-')

          Rule.new(
            name: name,
            lower_range: Integer(lower_lower)..Integer(lower_upper),
            upper_range: Integer(upper_lower)..Integer(upper_upper)
          )
        end
      end

      def initialize(name:, lower_range:, upper_range:)
        @name = name
        @lower_range = lower_range
        @upper_range = upper_range
      end

      attr_reader :name,
                  :lower_range,
                  :upper_range

      def valid?(value)
        lower_range.cover?(value) ||
          upper_range.cover?(value)
      end
    end

    class TicketScanner
      def initialize(rules:, tickets:)
        @rules = rules
        @tickets = tickets
      end

      attr_reader :rules,
                  :tickets

      def error_rate
        invalid_fields.sum
      end

      def departure_values(ticket)
        fields_solution.each.reduce([]) do |acc, (name, index)|
          if name.start_with?('departure')
            acc.push(ticket[index])
          else
            acc
          end
        end
      end

      def invalid_fields
        tickets.reduce([]) do |acc, ticket|
          ticket.reduce(acc) do |inner, field|
            if valid_for_any?(field)
              inner
            else
              inner.push(field)
            end
          end
        end
      end

      def fields_solution
        Solver.new(rules: rules, tickets: valid_tickets).solve
      end

      def valid_tickets
        tickets.select do |ticket|
          ticket.all? { |value| valid_for_any?(value) }
        end
      end

      def valid_for_any?(value)
        rules.any? { |rule| rule.valid?(value) }
      end
    end

    class Solver
      def initialize(rules:, tickets:)
        @rules = rules
        @tickets = tickets
        @len = tickets.first.length
        @potentials = calculate_potentials
        @solutions = {}
      end

      attr_reader :rules,
                  :tickets,
                  :len,
                  :solutions,
                  :potentials

      def solve
        return solutions if solutions.keys.length == rules.length

        name, _values = potentials.find { |_name, values| values.length == 1 }
        raise 'Cannot solve' if name.nil?

        value = potentials.delete(name).first
        solutions[name] = value

        potentials.each do |(pot_name, pot_values)|
          next if name == pot_name

          pot_values.delete(value)
        end

        solve
      end

      def calculate_potentials
        rules.reduce({}) do |acc, rule|
          acc.merge(rule.name => potential_indexes(rule))
        end
      end

      def potential_indexes(rule)
        (0..len).reduce([]) do |acc, idx|
          potential_index?(rule, idx) ? acc.push(idx) : acc
        end
      end

      def potential_index?(rule, idx)
        tickets.all? { |ticket| rule.valid?(ticket[idx]) }
      end
    end
  end
end
