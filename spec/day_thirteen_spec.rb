# frozen_string_literal: true

require_relative '../lib/aoc2020'

RSpec.describe Aoc2020::DayThirteen do
  describe '.part_two' do
    specify do
      expect(described_class.solve_congruence([7, 5], [6, 4])).to eq [42, 40]
      expect(described_class.solve_congruence([42, 40], [11, 10])).to eq [462, 208]
    end

    specify do
      expect(described_class.solve_congruences([[7, 5], [6, 4], [11, 10]])).to eq [462, 208]
    end

    # The earliest timestamp that matches the list 17,x,13,19 is 3417.
    specify do
      input = "_\n17,x,13,19"
      expect(described_class.part_two(input)).to eq 3417
    end

    # 67,7,59,61 first occurs at timestamp 754018
    specify do
      input = "_\n67,7,59,61"
      expect(described_class.part_two(input)).to eq 754_018
    end

    # 67,x,7,59,61 first occurs at timestamp 779210
    specify do
      input = "_\n67,x,7,59,61"
      expect(described_class.part_two(input)).to eq 779_210
    end

    # 67,7,x,59,61 first occurs at timestamp 1261476
    specify do
      input = "_\n67,7,x,59,61"
      expect(described_class.part_two(input)).to eq 1_261_476
    end

    # 1789,37,47,1889 first occurs at timestamp 1202161486
    specify do
      input = "_\n1789,37,47,1889"
      expect(described_class.part_two(input)).to eq 1_202_161_486
    end
  end
end
