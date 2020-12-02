# frozen_string_literal: true

require_relative '../lib/aoc2020'

RSpec.describe Aoc2020::DayTwo do
  describe 'Policy' do
    let(:policy) { described_class::Policy.new(min: 1, max: 3, char: 'a') }

    specify 'just right' do
      expect(policy.valid?('ababab')).to eq true
    end

    specify 'too many' do
      expect(policy.valid?('aaaa')).to eq false
    end

    specify 'too few' do
      expect(policy.valid?('bbb')).to eq false
    end
  end

  describe 'PasswordValidator' do
    let(:validator) { described_class::PasswordValidator.new(policy: '1-3 a', password: password) }

    context 'just right' do
      let(:password) { 'ababab' }

      specify { expect(validator).to be_valid }
    end

    context 'too many' do
      let(:password) { 'aaaa' }

      specify { expect(validator).not_to be_valid }
    end
  end
end
