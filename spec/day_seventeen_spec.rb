# frozen_string_literal: true

require_relative '../lib/aoc2020'

RSpec.describe Aoc2020::DaySeventeen do
  describe '.part_one' do
    specify do
      input = <<~IN
        .#
        ##
      IN

      plane = described_class.plane(input)
      dimension = described_class::Dimension.from_plane(plane)
      expect(dimension.points[[0, 0, 0]]).to eq :inactive
      expect(dimension.points[[0, 1, 0]]).to eq :active
      expect(dimension.points[[1, 0, 0]]).to eq :active
      expect(dimension.points[[1, 1, 0]]).to eq :active

      dimension.cycle!

      expect(dimension.points[[0, 0, 0]]).to eq :active
      expect(dimension.points[[0, 1, 0]]).to eq :active
      expect(dimension.points[[1, 0, 0]]).to eq :active
      expect(dimension.points[[1, 1, 0]]).to eq :active
      expect(dimension.points[[0, 0, 1]]).to eq :active
      expect(dimension.points[[0, 1, 1]]).to eq :active
      expect(dimension.points[[1, 0, 1]]).to eq :active
      expect(dimension.points[[1, 1, 1]]).to eq :active
      expect(dimension.points[[0, 0, -1]]).to eq :active
      expect(dimension.points[[0, 1, -1]]).to eq :active
      expect(dimension.points[[1, 0, -1]]).to eq :active
      expect(dimension.points[[1, 1, -1]]).to eq :active

      # puts dimension
    end

    specify do
      input = <<~IN
        .#.
        ..#
        ###
      IN
      plane = described_class.plane(input)
      dimension = described_class::Dimension.from_plane(plane)

      expect(dimension.points[[0, 0, 0]]).to eq :inactive
      expect(dimension.points[[0, 1, 0]]).to eq :active

      expected = <<~OUT
        z=0
        .#.
        ..#
        ###

      OUT

      expect(dimension.to_s).to eq expected

      dimension.cycle!
      # puts dimension

    #   expected1 = <<~OUT
    #     z=-1
    #     #..
    #     ..#
    #     .#.

    #     z=0
    #     #.#
    #     .##
    #     .#.

    #     z=1
    #     #..
    #     ..#
    #     .#.
    #   OUT

    #   expect(dimension.to_s).to eq expected1
    end
  end
end
