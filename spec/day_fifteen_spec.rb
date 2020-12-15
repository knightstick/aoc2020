# frozen_string_literal: true

require_relative '../lib/aoc2020'

RSpec.describe Aoc2020::DayFifteen do
  describe '.part_one' do
    specify do
      expect(described_class.part_one('0,3,6', 10)).to eq 0
      expect(described_class.part_one('1,3,2')).to eq 1
      expect(described_class.part_one('2,1,3')).to eq 10
      expect(described_class.part_one('1,2,3')).to eq 27
    end
  end
end
