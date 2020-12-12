# frozen_string_literal: true

require_relative '../lib/aoc2020'

RSpec.describe Aoc2020::DayTwelve do
  describe '.part_one' do
    specify do
      input = <<~IN
        F10
        N3
        F7
        R90
        F11
      IN

      expect(described_class.part_one(input)).to eq 25
    end
  end

  describe '.part_two' do
    specify do
      input = <<~IN
        F10
        N3
        F7
        R90
        F11
      IN

      expect(described_class.part_two(input)).to eq 286
    end

    specify do
      expect(described_class::WaypointShip.new.waypoint).to eq [10, 1]
      expect(described_class::WaypointShip.new.tap { |ship| ship.move(action: 'R', value: 90) }.waypoint).to eq [1, -10]
      expect(described_class::WaypointShip.new.tap { |ship| ship.move(action: 'R', value: 180) }.waypoint).to eq [-10, -1]
      expect(described_class::WaypointShip.new.tap { |ship| ship.move(action: 'R', value: 270) }.waypoint).to eq [-1, 10]
    end
  end
end
