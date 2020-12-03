# frozen_string_literal: true

require_relative '../lib/aoc2020'

RSpec.describe Aoc2020::DayThree do
  describe 'Grid' do
    let(:grid) { described_class::Grid.from_string(string) }

    context 'one row' do
      let(:string) { ".#.\n" }

      specify do
        expect(grid.at(x: 0, y: 0)).to_not be_a_tree
      end

      specify do
        expect(grid.at(x: 0, y: 1)).to be_a_tree
      end

      specify do
        expect(grid.at(x: 0, y: 2)).to_not be_a_tree
      end
    end

    context 'three rows' do
      let(:string) { "...\n.#.\n#.#" }

      specify do
        expect(grid.at(x: 0, y: 0)).to_not be_a_tree
      end

      specify do
        expect(grid.at(x: 1, y: 1)).to be_a_tree
      end

      specify do
        expect(grid.at(x: 2, y: 2)).to be_a_tree
      end
    end

    describe 'next_position' do
      let(:grid) { described_class::Grid.from_string("...\n...\n...") }

      def next_position(x:, y:, x_diff:, y_diff:)
        grid.next_position(x: x, y: y, slope: OpenStruct.new(right: y_diff, down: x_diff))
      end

      specify do
        expect(next_position(x: 0, y: 0, x_diff: 1, y_diff: 0)).to eq({ x: 1, y: 0 })
      end

      specify do
        expect(next_position(x: 1, y: 0, x_diff: 1, y_diff: 0)).to eq({ x: 2, y: 0 })
      end

      specify do
        expect(next_position(x: 0, y: 0, x_diff: 2, y_diff: 0)).to eq({ x: 2, y: 0 })
      end

      specify do
        expect(next_position(x: 0, y: 0, x_diff: 0, y_diff: 2)).to eq({ x: 0, y: 2 })
      end

      specify do
        expect(next_position(x: 0, y: 0, x_diff: 0, y_diff: 3)).to eq({ x: 0, y: 0 })
      end

      specify do
        expect(next_position(x: 0, y: 0, x_diff: 3, y_diff: 0)).to be_nil
      end

      context 'another' do
        let(:grid) { described_class::Grid.from_string("....\n...#\n....") }

        specify do
          expect(next_position(x: 1, y: 3, x_diff: 1, y_diff: 3)).to eq({ x: 2, y: 2 })
        end

        specify do
          expect(grid.next_position(x: 0, y: 0, slope: OpenStruct.new(down: 1, right: 3))).to eq({ x: 1, y: 3 })
        end
      end
    end
  end

  describe 'Toboggan Ride' do
    let(:grid) { described_class::Grid.from_string("....\n...#\n....") }
    let(:toboggan_ride) { described_class::TobogganRide.new(grid: grid) }

    specify { expect(toboggan_ride.number_of_trees).to eq 1 }
  end
end
