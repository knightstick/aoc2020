# frozen_string_literal: true

require_relative '../lib/aoc2020'

RSpec.describe Aoc2020::DayEleven do
  describe '.part_one' do
    specify do
      input = <<~IN
        L.LL.LL.LL
        LLLLLLL.LL
        L.L.L..L..
        LLLL.LL.LL
        L.LL.LL.LL
        L.LLLLL.LL
        ..L.L.....
        LLLLLLLLLL
        L.LLLLLL.L
        L.LLLLL.LL
      IN

      expect(described_class.part_one(input)).to eq 37
    end
  end

  describe '.part_two' do
    specify do
      input = <<~IN
        L.LL.LL.LL
        LLLLLLL.LL
        L.L.L..L..
        LLLL.LL.LL
        L.LL.LL.LL
        L.LLLLL.LL
        ..L.L.....
        LLLLLLLLLL
        L.LLLLLL.L
        L.LLLLL.LL
      IN

      expect(described_class.part_two(input)).to eq 26
    end
  end

  specify do
    input = <<~IN
      #.##.##.##
      #######.##
      #.#.#..#..
      ####.##.##
      #.##.##.##
      #.#####.##
      ..#.#.....
      ##########
      #.######.#
      #.#####.##
    IN

    grid = described_class.grid(input)
    out, = described_class.step(grid, :new_state_visible)

    expected_string = <<~OUT
      #.LL.LL.L#
      #LLLLLL.LL
      L.L.L..L..
      LLLL.LL.LL
      L.LL.LL.LL
      L.LLLLL.LL
      ..L.L.....
      LLLLLLLLL#
      #.LLLLLL.L
      #.LLLLL.L#
    OUT
    expected = described_class.grid(expected_string)

    expect(out).to eq expected
  end
end
