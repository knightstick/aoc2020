module Aoc2020
  module DayEight
    class << self
      def part_one(input)
        instructions = Handheld.parse_instructions(input.chomp)
        Handheld.new(instructions: instructions).last_value
      end

      def part_two(input)
        instructions = Handheld.parse_instructions(input.chomp)

        initial = Handheld.new(instructions: instructions).terminated_value

        return initial unless initial.nil?

        instructions.each.with_index do |instruction, index|
          inverted_instruction = Handheld.mutate(instruction)
          mutated_instructions = instructions[0...index] + [inverted_instruction] + instructions[index + 1..]
          terminated_value = Handheld.new(instructions: mutated_instructions).terminated_value
          break terminated_value unless terminated_value.nil?
        end
      end
    end

    class Handheld
      class << self
        def parse_instructions(input)
          input.split("\n").map do |line|
            instruction_from_line(line)
          end
        end

        def instruction_from_line(line)
          type, value = line.split(' ')

          if %w[nop acc jmp].include? type
            [type.to_sym, Integer(value)]
          else
            raise "unknown instruction #{type.inspect}"
          end
        end

        def mutate(instruction)
          type, value = instruction

          case type
          when :nop
            [:jmp, value]
          when :jmp
            [:nop, value]
          else
            instruction
          end
        end
      end

      def initialize(instructions:, accumulator: 0, next_instruction: 0)
        @instructions = instructions
        @accumulator = accumulator
        @next_instruction = next_instruction
        @executed_instructions = []
      end

      def last_value
        return accumulator if executed_instructions.include? next_instruction

        step

        last_value
      end

      def terminated_value
        return nil if executed_instructions.include? next_instruction
        return accumulator if next_instruction == instructions.length

        step

        terminated_value
      end

      def step
        execute(instructions[next_instruction])
      end

      private

      attr_reader :instructions

      attr_accessor :next_instruction,
                    :accumulator,
                    :executed_instructions

      def execute(instruction)
        type, value = instruction

        case type
        when :nop
          executed_instructions << next_instruction
          self.next_instruction = next_instruction + 1
        when :acc
          executed_instructions << next_instruction
          self.accumulator = accumulator + value
          self.next_instruction = next_instruction + 1
        when :jmp
          executed_instructions << next_instruction
          self.next_instruction = next_instruction + value
        else
          raise NotImplementedError, "Dunno how to execute #{type.inspect}"
        end
      end
    end
  end
end
