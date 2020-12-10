# frozen_string_literal: true

require_relative '../lib/aoc2020'

RSpec.describe Aoc2020::DayTen do
  describe '.part_one' do
    specify do
      input = <<~IN
        16
        10
        15
        5
        1
        11
        7
        19
        6
        12
        4
      IN

      expect(described_class.part_one(input)).to eq 7 * 5
    end
  end

  describe '.part_two' do
    specify do
      input = <<~IN
        1
        2
        3
      IN

      # 0 1 2 3 6
      # 0 1 3 6
      # 0 2 3 6
      # 0 3 6
      expect(described_class.part_two(input)).to eq 4
    end
  end
end
