# frozen_string_literal: true

require_relative '../lib/aoc2020'

RSpec.describe Aoc2020::DayEighteen do
  describe 'part_one' do
    specify do
      expect_output('1 + 2', 3)
      expect_output('1 + 3', 4)
      expect_output('2 * 3', 6)
      expect_output('1 + 2 * 3', 9)
      expect_output('3 * 2 + 1', 7)
      expect_output('1 + 2 * 3 + 4 * 5 + 6', 71)
    end

    specify do
      expect_output('(1 + 2)', 3)
      expect_output('1 + (2 * 3)', 7)
      expect_output('1 + (2 * 3) + (4 * (5 + 6))', 51)

      expect_output('2 * 3 + (4 * 5)', 26)
      expect_output('5 + (8 * 3 + 9 + 3 * 4 * 3)', 437)
      expect_output('5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))', 12_240)
      expect_output('((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2', 13_632)
    end

    def expect_output(input, output)
      expect(described_class.part_one(input)).to eq output
    end
  end

  describe 'part_two' do
    def expect_output(input, output)
      expect(described_class.part_two(input)).to eq output
    end

    specify do
      expect_output('1 + 2', 3)
      expect_output('1 + 2 + 3', 6)
      expect_output('3 * 2 * 4', 24)
      expect_output('1 + (2 * 3) + (4 * (5 + 6))', 51)
      expect_output('2 * 3 + (4 * 5)', 46)
      expect_output('8 * 3 + 9 + 3 * 4 * 3', 1440)
      expect_output('5 + (8 * 3 + 9 + 3 * 4 * 3)', 1445)
      expect_output('7 * 3 * 3 + 9 * 3 +  56 ', (7 * 3 * 12 * 59))
      expect_output('7 * 3 * 3 + 9 * 3 + (8 + 6 * 4)', 14_868)
      expect_output('5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))', 669_060)
      expect_output('((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2', 23_340)
    end
  end
end
