module Aoc2020
  module DayTwentyTwo
    class << self
      def part_one(input)
        deck1, deck2 = input.split("\n\n").map(&method(:parse_deck))
        game = Combat.new(deck1, deck2)
        game.play
        game.winning_score
      end

      def part_two(input)
        deck1, deck2 = input.split("\n\n").map(&method(:parse_deck))
        game = RecursiveCombat.new(deck1, deck2)
        game.play
        game.winning_score
      end

      def parse_deck(string)
        _name, *cards = string.split("\n")

        Deck.new(cards.map(&method(:Integer)))
      end
    end

    class Deck
      def initialize(cards)
        @cards = cards
      end

      attr_accessor :cards

      def draw!
        top, *rest = cards
        self.cards = rest
        top
      end

      def append(*new_cards)
        cards.append(*new_cards)
      end

      def empty?
        cards.empty?
      end

      def score
        cards.reverse.map.with_index do |card, index|
          card * (index + 1)
        end.sum
      end

      def cards_remaining
        cards.length
      end

      def take(number)
        Deck.new(cards.take(number))
      end
    end

    class Combat
      def initialize(deck1, deck2)
        @deck1 = deck1
        @deck2 = deck2
        @round = 1
      end

      attr_accessor :deck1,
                    :deck2,
                    :winner,
                    :round

      def play
        # puts self
        return unless winner.nil?

        card1, card2 = draw_cards!
        award_cards_to_winner(card1, card2)

        self.winner = :player2 if deck1.empty?
        self.winner = :player1 if deck2.empty?

        self.round += 1
        play
      end

      def winning_score
        case winner
        when :player1
          deck1.score
        when :player2
          deck2.score
        end
      end

      def draw_cards!
        [deck1.draw!, deck2.draw!]
      end

      def award_cards_to_winner(card1, card2)
        # puts "Player 1 plays: #{card1}"
        # puts "Player 2 plays: #{card2}"

        case card1 <=> card2
        when -1
          # puts "Player 2 wins the round!\n"
          deck2.append(card2, card1)
        when 0
          raise NotImplementedError
        when 1
          # puts "Player 1 wins the round!\n"
          deck1.append(card1, card2)
        end
      end

      def to_s
        "-- Round #{round} --\n" \
        "Player 1's deck: #{deck1.cards.join(', ')}\n" \
          "Player 2's deck: #{deck2.cards.join(', ')}"
      end
    end

    class RecursiveCombat
      def initialize(deck1, deck2, game = 1)
        @deck1 = deck1
        @deck2 = deck2
        @game = game
        @round = 1
        @previous_configurations = []

        # puts "\n=== Game #{game} ===\n\n"
      end

      attr_reader :deck1,
                  :deck2,
                  :previous_configurations,
                  :game

      attr_accessor :round,
                    :winner

      def play
        return infinite_detected unless new_configuration?
        return unless winner.nil?

        previous_configurations << current_configuration

        # puts self

        card1, card2 = draw_cards!
        award_cards_to_winner(card1, card2)

        self.winner = :player2 if deck1.empty?
        self.winner = :player1 if deck2.empty?

        self.round += 1
        play
      end

      def new_configuration?
        !previous_configurations.include?(current_configuration)
      end

      def current_configuration
        [deck1.cards, deck2.cards]
      end

      def draw_cards!
        [deck1.draw!, deck2.draw!]
      end

      def winning_score
        case winner
        when :player1
          deck1.score
        when :player2
          deck2.score
        end
      end

      def to_s
        "-- Round #{round} (Game #{game})--\n" \
        "Player 1's deck: #{deck1.cards.join(', ')}\n" \
          "Player 2's deck: #{deck2.cards.join(', ')}"
      end

      def can_recurse?(card1, card2)
        deck1.cards_remaining >= card1 &&
          deck2.cards_remaining >= card2
      end

      def award_cards_to_winner(card1, card2)
        # puts "Player 1 plays: #{card1}"
        # puts "Player 2 plays: #{card2}"

        if can_recurse?(card1, card2)
          award_recursive_winner(card1, card2)
        else
          award_based_on_value(card1, card2)
        end
      end

      def award_based_on_value(card1, card2)
        case card1 <=> card2
        when -1
          # puts "Player 2 wins the round!\n"
          deck2.append(card2, card1)
        when 0
          raise NotImplementedError
        when 1
          # puts "Player 1 wins the round!\n"
          deck1.append(card1, card2)
        end
      end

      def award_recursive_winner(card1, card2)
        new_deck1 = deck1.take(card1)
        new_deck2 = deck2.take(card2)

        recursive_game = RecursiveCombat.new(new_deck1, new_deck2)
        recursive_game.play
        winner = recursive_game.winner

        case winner
        when :player1
          # puts "Player 1 wins the round!\n"
          deck1.append(card1, card2)
        when :player2
          # puts "Player 2 wins the round!\n"
          deck2.append(card2, card1)
        else
          raise 'Urm, nobody won I guess?'
        end
      end

      def infinite_detected
        self.winner = :player1
      end
    end
  end
end
