# frozen_string_literal: true

require_relative '../lib/aoc2020'

RSpec.describe Aoc2020::DayEight do
  describe 'part_one' do
    specify do
      input = <<-INSTRUCTIONS
        nop +0
        acc +1
        jmp +4
        acc +3
        jmp -3
        acc -99
        acc +1
        jmp -4
        acc +6
      INSTRUCTIONS

      instructions = described_class::Handheld.parse_instructions(input)
      expect(described_class::Handheld.new(instructions: instructions).last_value).to eq 5
    end
  end

  describe 'part_two' do
    specify do
      input = <<-INSTRUCTIONS
        nop +0
        acc +1
        jmp +4
        acc +3
        jmp -3
        acc -99
        acc +1
        jmp -4
        acc +6
      INSTRUCTIONS

      instructions = described_class::Handheld.parse_instructions(input)
      expect(described_class::Handheld.new(instructions: instructions).terminated_value).to be_nil
      expect(described_class::part_two(input)).to eq 8
    end

    specify do
      input = <<-INSTRUCTIONS
        nop +0
        acc +1
        jmp +4
        acc +3
        jmp -3
        acc -99
        acc +1
        nop -4
        acc +6
      INSTRUCTIONS

      instructions = described_class::Handheld.parse_instructions(input)
      expect(described_class::Handheld.new(instructions: instructions).terminated_value).to eq 8
    end
  end
end
