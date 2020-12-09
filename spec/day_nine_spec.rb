# frozen_string_literal: true

require_relative '../lib/aoc2020'

RSpec.describe Aoc2020::DayNine do
  describe 'part one' do
    specify do
      input = <<~IN
        35
        20
        15
        25
        47
        40
        62
        55
        65
        95
        102
        117
        150
        182
        127
        219
        299
        277
        309
        576
      IN

      expect(described_class.part_one(input, 5)).to eq 127
    end

    specify do
      input = <<~IN
        35
        20
        15
        25
        47
        40
        62
        55
        65
        95
        102
        117
        150
        182
        127
        219
        299
        277
        309
        576
      IN

      expect(described_class.part_two(input, 5)).to eq 62
    end
  end
end
