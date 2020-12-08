# frozen_string_literal: true

require_relative '../lib/aoc2020'

RSpec.describe Aoc2020::DaySeven do
  describe 'part_one' do
    specify do
      input = ['dotted black bags contain no other bags.']
      rules = described_class.bag_rules(input)
      expect(rules['dotted black']).to eq false
    end

    specify do
      input = ['faded blue bags contain no other bags.']
      rules = described_class.bag_rules(input)
      expect(rules['faded blue']).to eq false
    end

    specify do
      input = ['shiny gold bags contain no other bags.']
      rules = described_class.bag_rules(input)
      expect(rules['shiny gold']).to eq true
    end

    specify do
      input = ['light red bags contain 1 dotted black bag.',
               'dotted black bags contain no other bags.']
      rules = described_class.bag_rules(input)
      expect(rules['light red']).to eq false
    end

    specify do
      input = ['light red bags contain 1 shiny gold bag.',
               'shiny gold bags contain no other bags.']
      rules = described_class.bag_rules(input)
      expect(rules['light red']).to eq true
    end

    specify do
      input = ['light red bags contain 1 bright blue bag.',
               'bright blue bags contain no other bags.']
      rules = described_class.bag_rules(input)
      expect(rules['light red']).to eq false
    end

    specify do
      input = ['light red bags contain 2 bright blue bags, 3 shiny gold bags.',
               'bright blue bags contain no other bags.',
               'shiny gold bags contain no other bags.']
      rules = described_class.bag_rules(input)
      expect(rules['light red']).to eq true
    end

    specify do
      input = [
        'bright blue bags contain 1 shiny gold bag.',
        'light red bags contain 2 bright blue bags.',
        'shiny gold bags contain no other bags.'
      ]

      rules = described_class.bag_rules(input)
      expect(rules['bright blue']).to eq true
      expect(rules['light red']).to eq true
    end

    specify do
      input = <<~BAGS
        light red bags contain 1 bright white bag, 2 muted yellow bags.
        dark orange bags contain 3 bright white bags, 4 muted yellow bags.
        bright white bags contain 1 shiny gold bag.
        muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
        shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
        dark olive bags contain 3 faded blue bags, 4 dotted black bags.
        vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
        faded blue bags contain no other bags.
        dotted black bags contain no other bags.
      BAGS

      expect(described_class.part_one(input)).to eq 4
    end

    specify do
      input = <<~BAGS
        shiny gold bags contain 2 dark red bags.
        dark red bags contain 2 dark orange bags.
        dark orange bags contain 2 dark yellow bags.
        dark yellow bags contain 2 dark green bags.
        dark green bags contain 2 dark blue bags.
        dark blue bags contain 2 dark violet bags.
        dark violet bags contain no other bags.
      BAGS

      expect(described_class.part_two(input)).to eq 126
    end
  end
end
