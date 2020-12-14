# frozen_string_literal: true

require_relative '../lib/aoc2020'

RSpec.describe Aoc2020::DayFourteen do
  describe '.part_one' do
    # specify do
    #   computer = described_class::Computer.new
    #   computer.execute([:mask, 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X'])
    #   computer.execute([:write, 8, 11])
    #   expect(computer.memory[8].to_s(2)).to eq 73.to_s(2)
    # end

    specify do
      computer = described_class::Computer.new
      computer.execute([:mask, 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX1'])
      computer.execute([:write, 8, 1])
      expect(computer.memory[8].to_s(2)).to eq '1'.to_i(2).to_s(2)

      computer.execute([:mask, 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX1x'])
      computer.execute([:write, 8, 1])
      expect(computer.memory[8].to_s(2)).to eq '11'.to_i(2).to_s(2)

      computer.execute([:mask, 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX0'])
      computer.execute([:write, 8, 1])
      expect(computer.memory[8].to_s(2)).to eq '0'.to_i(2).to_s(2)

      computer.execute([:mask, 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX0'])
      computer.execute([:write, 8, 2])
      expect(computer.memory[8].to_s(2)).to eq '10'.to_i(2).to_s(2)
    end

    specify do
      computer = described_class::ComputerV2.new
      computer.execute([:mask, '000000000000000000000000000000X1001X'])
      computer.execute([:write, 42, 100])
      expect(computer.memory[26]).to eq 100
      expect(computer.memory[27]).to eq 100
      expect(computer.memory[58]).to eq 100
      expect(computer.memory[59]).to eq 100

      computer.execute([:mask, '00000000000000000000000000000000X0XX'])
      computer.execute([:write, 26, 1])

      [16, 17, 18, 19, 24, 25, 26, 27].each do |address|
        expect(computer.memory[address]).to eq 1
      end
    end
  end
end
