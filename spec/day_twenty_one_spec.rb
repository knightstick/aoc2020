# frozen_string_literal: true

require_relative '../lib/aoc2020'

RSpec.describe Aoc2020::DayTwentyOne do
  describe '.part_one' do
    specify do
      input = <<~IN
        mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
        trh fvjkl sbzzf mxmxvkd (contains dairy)
        sqjhc fvjkl (contains soy)
        sqjhc mxmxvkd sbzzf (contains fish)
      IN

      recipe_list = described_class::RecipeList.parse(input)
      expect(recipe_list.cannot_be_allergen).to match_array(%w[kfcds nhms sbzzf trh])
    end
  end

  describe '.part_two' do
    specify do
      input = <<~IN
        mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
        trh fvjkl sbzzf mxmxvkd (contains dairy)
        sqjhc fvjkl (contains soy)
        sqjhc mxmxvkd sbzzf (contains fish)
      IN

      recipe_list = described_class::RecipeList.parse(input)
      potentials = recipe_list.potential_allergens
      expect(potentials).to eq(
        'dairy' => %w[mxmxvkd].to_set,
        'fish' => %w[sqjhc mxmxvkd].to_set,
        'soy' => %w[sqjhc fvjkl].to_set
      )

      solver = described_class::Solver.new(potentials)
      solution = solver.solve
      expect(solution).to eq(
        'mxmxvkd' => 'dairy',
        'sqjhc' => 'fish',
        'fvjkl' => 'soy'
      )

      expect(described_class.part_two(input)).to eq "mxmxvkd,sqjhc,fvjkl"
    end
  end
end
