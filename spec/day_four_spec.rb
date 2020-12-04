# frozen_string_literal: true

require_relative '../lib/aoc2020'

RSpec.describe Aoc2020::DayFour do
  describe 'actually_valid?' do
    def expect_valid(string)
      expect(described_class.actually_valid?(string)).to eq true
    end

    def expect_not_valid(string)
      expect(described_class.actually_valid?(string)).to eq false
    end

    specify do
      expect_valid("pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980\nhcl:#623a2f")
    end

    specify do
      expect_not_valid("eyr:1972 cid:100\nhcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926")
    end

    specify do
      expect_not_valid("iyr:2019\nhcl:#602927 eyr:1967 hgt:170cm\necl:grn pid:012533040 byr:1946")
    end

    specify do
      expect_not_valid("hcl:dab227 iyr:2012\necl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277")
    end

    specify do
      expect_not_valid("hgt:59cm ecl:zzz\neyr:2038 hcl:74454a iyr:2023\npid:3556412378 byr:2007")
    end

let(:valid) do
<<-VALID
pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
hcl:#623a2f

eyr:2029 ecl:blu cid:129 byr:1989
iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

hcl:#888785
hgt:164cm byr:2001 iyr:2015 cid:88
pid:545766238 ecl:hzl
eyr:2022

iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719
VALID
end

    specify do
      expect(described_class.part_two(valid)).to eq 4
    end

    specify do
      expect(described_class.valid_birth_year?("2002")).to eq true
      expect(described_class.valid_birth_year?("2003")).to eq false
      expect(described_class.valid_birth_year?(nil)).to eq false
    end

    specify do
      expect(described_class.valid_issue_year?("2010")).to eq true
      expect(described_class.valid_issue_year?("2009")).to eq false
      expect(described_class.valid_issue_year?("2021")).to eq false
      expect(described_class.valid_issue_year?(nil)).to eq false
    end

    specify do
      expect(described_class.valid_expiration_year?("2025")).to eq true
      expect(described_class.valid_expiration_year?("2019")).to eq false
      expect(described_class.valid_expiration_year?("2031")).to eq false
      expect(described_class.valid_expiration_year?(nil)).to eq false
    end

    specify do
      expect(described_class.valid_height?('149cm')).to eq false
      expect(described_class.valid_height?('150cm')).to eq true
      expect(described_class.valid_height?('193cm')).to eq true
      expect(described_class.valid_height?('194cm')).to eq false

      expect(described_class.valid_height?('58in')).to eq false
      expect(described_class.valid_height?('59in')).to eq true
      expect(described_class.valid_height?('76in')).to eq true
      expect(described_class.valid_height?('77in')).to eq false

      expect(described_class.valid_height?(nil)).to eq false
    end

    specify do
      expect(described_class.valid_hair_color?('#000000')).to eq true
      expect(described_class.valid_hair_color?('#0000000')).to eq false
      expect(described_class.valid_hair_color?('#00000')).to eq false
      expect(described_class.valid_hair_color?('0000000')).to eq false

      expect(described_class.valid_hair_color?('#abcdef')).to eq true
      expect(described_class.valid_hair_color?('#123456')).to eq true
      expect(described_class.valid_hair_color?('#789000')).to eq true

      expect(described_class.valid_hair_color?(nil)).to eq false
    end

    specify do
      %w[amb blu brn gry grn hzl oth].each do |color|
        raise "color: #{color}" unless described_class.valid_eye_color?(color) == true
        expect(described_class.valid_eye_color?(color)).to eq true
      end

      expect(described_class.valid_eye_color?('foo')).to eq false
      expect(described_class.valid_eye_color?(nil)).to eq false
    end

    specify do
      expect(described_class.valid_pid?('123456789')).to eq true
      expect(described_class.valid_pid?('12345678')).to eq false
      expect(described_class.valid_pid?('1234567890')).to eq false

      expect(described_class.valid_pid?(nil)).to eq false
    end
  end
end
