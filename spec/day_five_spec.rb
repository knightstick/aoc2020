# frozen_string_literal: true

require_relative '../lib/aoc2020'

RSpec.describe Aoc2020::DayFive do
  describe 'part_one' do
    specify do
      expect(described_class.row('BFFFBBF')).to eq 70
    end

    specify do
      expect(described_class.column('RRR')).to eq 7
    end
  end
end
