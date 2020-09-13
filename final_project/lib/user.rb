require_relative 'bill'

class User
  attr_reader :name, :cards, :score, :bill

  def initialize(name:, money:)
    @name = name.capitalize
    @bill = Bill.new(money)
    @cards = []
    @score = 0
  end

  def new_game
    self.cards = []
    self.score = 0
  end

  def add_card(card)
    cards << card
    self.score += card.value
    counting
  end

  def counting
    free_points = cards.select { |card| card.value == 11 }.count
    self.score -= 10 while score > 21 && free_points.positive?
  end

  def show_cards
    cards.map(&:name)
  end

  def balance
    bill.money
  end

  def take_money(value)
    bill.take_money(value)
  rescue ArgumentError => e
    puts "ERROR: #{e.message}"
    exit
  end

  def add_money(value)
    bill.add_money(value)
  end

  private

  attr_writer :cards, :score
end
