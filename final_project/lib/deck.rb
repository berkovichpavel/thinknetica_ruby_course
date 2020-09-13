require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    cards = Card::RANKS.product(Card::SUITS)
    @cards = cards.map do |rank, suit|
      Card.new(rank, suit, Card.cost(rank))
    end
  end

  def take_card
    card = cards.sample
    cards.delete(card)
  end
end
