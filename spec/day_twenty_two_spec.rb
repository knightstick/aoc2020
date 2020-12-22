# frozen_string_literal: true

require_relative '../lib/aoc2020'

RSpec.describe Aoc2020::DayTwentyTwo do
  describe '.part_one' do
    specify do
      input = <<~IN
        Player 1:
        9
        2
        6
        3
        1

        Player 2:
        5
        8
        4
        7
        10
      IN

      expect(described_class.part_one(input)).to eq 306
    end
  end

  describe '.part_two' do
    specify 'infinite prevention' do
      input = <<~IN
        Player 1:
        43
        19

        Player 2:
        2
        29
        14
      IN

      expect(described_class.part_two(input)).to eq 105
    end

    specify do
      input = <<~IN
        Player 1:
        9
        2
        6
        3
        1

        Player 2:
        5
        8
        4
        7
        10
      IN

      expect(described_class.part_two(input)).to eq 291
    end
  end
end
