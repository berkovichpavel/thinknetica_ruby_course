class Card
  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K T].freeze
  SUITS = %w[♠ ♥ ♣ ♦].freeze

  attr_reader :name, :value

  def initialize(rank, type, value)
    @name = "#{rank}#{type}"
    @value = value
  end

  def self.cost(rank)
    return 11 if rank == 'T'
    return 10 if %w[J Q K].include?(rank)

    rank.to_i
  end
end
