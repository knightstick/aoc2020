# frozen_string_literal: true

require_relative '../lib/aoc2020'

RSpec.describe Aoc2020::DayTwentyThree do
  describe '.part_one' do
    specify do
      input = <<~IN
        389125467
      IN

      expect(described_class.part_one(input, 10)).to eq '92658374'
    end
  end
end
