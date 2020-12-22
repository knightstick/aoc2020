require 'ostruct'

module Aoc2020
  module DayTwentyOne
    class << self
      def part_one(input)
        recipe_list = RecipeList.parse(input)
        not_allergens = recipe_list.cannot_be_allergen

        not_allergens.map do |ingredient|
          recipe_list.number_of_foods_containing(ingredient)
        end.sum
      end

      def part_two(input)
        recipe_list = RecipeList.parse(input)
        solver = Solver.new(recipe_list.potential_allergens)
        solution = solver.solve
        solution.sort_by { |_i, a| a }.map { |i, _a| i }.join(',')
      end
    end

    class RecipeList
      class << self
        def parse(input)
          ingredients_list = input.chomp.split("\n").map(&method(:parse_line))
          new(lines: ingredients_list)
        end

        def parse_line(line)
          ingredients, allergens = line.match(/(.*) \(contains (.*)\)/).captures
          OpenStruct.new(
            ingredients: ingredients.split(' '),
            allergens: allergens.split(', ')
          )
        end
      end

      def initialize(lines:)
        @lines = lines
      end

      attr_reader :lines

      def cannot_be_allergen
        all_ingredients.select do |ingredient|
          potential_allergens.none? do |_allergen, ingredients|
            ingredients.include?(ingredient)
          end
        end
      end

      def number_of_foods_containing(ingredient)
        lines.map do |line|
          line.ingredients.include?(ingredient)
        end.count(&:itself)
      end

      def potential_allergens
        @potential_allergens ||=
          calculate_potentials
      end

      def all_ingredients
        @all_ingredients ||=
          lines.reduce(Set.new) do |set, line|
            set.merge(line.ingredients)
          end
      end

      def calculate_potentials
        potentials = {}

        lines.each do |line|
          line.allergens.each do |allergen|
            potentials[allergen] = if potentials.key? allergen
                                     potentials[allergen].intersection(line.ingredients)
                                   else
                                     line.ingredients.to_set
                                   end
          end
        end

        potentials
      end
    end

    class Solver
      def initialize(rules)
        @rules = rules
      end

      attr_reader :rules

      def solution?(candidate)
        if candidate.keys.length == rules.keys.length
          candidate.all? do |ingredient, allergen|
            rules[allergen].include? ingredient
          end
        end
      end

      def unsolved(candidate)
        rules.select do |allergen, _ingredients|
          !candidate.value?(allergen)
        end.reduce({}) do |acc, (allergen, ingredients)|
          acc.merge(allergen => ingredients.reject { |i| candidate.key? i })
        end
      end

      def solve(candidate = {}, round = 0)
        return candidate if solution?(candidate)

        unsolved(candidate).each do |allergen, ingredients|
          ingredients.each do |ingredient|
            potential_solution = solve(candidate.merge(ingredient => allergen), round)
            return potential_solution if potential_solution
          end
        end

        solve(get_next_candidate(round), round + 1)
      end

      def get_next_candidate(round)
        new_allergen, new_ingredient = steps[round + 1]

        { new_ingredient => new_allergen }
      end

      def steps
        rules.reduce([]) do |acc, (allergen, ingredients)|
          acc + ingredients.map { |i| [allergen, i] }
        end
      end
    end
  end
end
