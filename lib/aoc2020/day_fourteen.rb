module Aoc2020
  module DayFourteen
    class << self
      def part_one(input)
        instructions = input.chomp.split("\n").map do |line|
          parse_instruction(line)
        end

        computer = Computer.new

        instructions.each do |instruction|
          computer.execute(instruction)
        end

        computer.memory_sum
      end

      def part_two(input)
        instructions = input.chomp.split("\n").map do |line|
          parse_instruction(line)
        end

        computer = ComputerV2.new

        instructions.each do |instruction|
          computer.execute(instruction)
        end

        computer.memory_sum
      end

      def parse_instruction(line)
        if line.start_with?('mask')
          _, mask = line.split(' = ')
          [:mask, mask]
        elsif line.start_with?('mem')
          address, value = line.scanf('mem[%d] = %d')

          [:write, Integer(address), Integer(value)]
        else
          raise "Unknown instruction #{line.inspect}"
        end
      end
    end

    class Computer
      def initialize
        @memory = Hash.new(0)
        @mask = 'x' * 36
      end

      def execute(instruction)
        instruction_type, *_values = instruction

        case instruction_type
        when :mask
          _, new_mask = instruction
          self.mask = new_mask
        when :write
          _, address, value = instruction
          write_to_memory(address, value)
        else
          raise "Unknown instruction type #{instruction_type}"
        end
      end

      def memory_sum
        memory.values.sum
      end

      def to_s
        {
          mask: mask,
          memory: memory.inspect
        }.inspect
      end

      # private

      attr_reader :memory
      attr_accessor :mask

      def write_to_memory(address, value)
        new_value = apply_mask(value)
        memory[address] = new_value
      end

      def apply_mask(value)
        mask.chars.reverse.each.with_index.reduce(value) do |value_acc, (char, idx)|
          case char
          when 'X', 'x'
            value_acc
          when '1'
            value_acc | (1 << idx)
          when '0'
            value_acc & ~(1 << idx)
          else
            raise "Unknown mask value #{char}"
          end
        end
      end
    end

    class ComputerV2
      def initialize
        @memory = Hash.new(0)
        @mask = 'x' * 36
      end

      def execute(instruction)
        instruction_type, *_values = instruction

        case instruction_type
        when :mask
          _, new_mask = instruction
          self.mask = new_mask
        when :write
          _, address, value = instruction
          write_to_memory(address, value)
        else
          raise "Unknown instruction type #{instruction_type}"
        end
      end

      def memory_sum
        memory.values.sum
      end

      def to_s
        {
          mask: mask,
          memory: memory.inspect
        }.inspect
      end

      # private

      attr_reader :memory
      attr_accessor :mask

      def write_to_memory(address, value)
        write_addresses = apply_mask(address, value)
        write_addresses.each do |new_address|
          memory[new_address] = value
        end
      end

      def apply_mask(address, _value)
        address_mask = address_mask(address)
        write_addresses(address_mask)
      end

      def address_mask(address)
        mask.chars.each.with_index.reduce('%036b' % address) do |address_acc, (char, index)|
          case char
          when 'x', 'X'
            address_acc[index] = 'X'
            address_acc
          when '1'
            address_acc[index] = '1'
            address_acc
          when '0'
            address_acc
          else
            raise "Unknown mask value #{char}"
          end
        end
      end

      def write_addresses(address_mask)
        x_count = address_mask.count 'X'
        [0, 1].repeated_permutation(x_count).map do |values|
          new_mask = address_mask.dup
          values.each do |value|
            new_mask.sub!('X', value.to_s)
          end
          new_mask.to_i(2)
        end
      end
    end
  end
end
