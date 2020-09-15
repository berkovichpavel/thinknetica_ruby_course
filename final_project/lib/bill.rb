class Bill
  attr_reader :money

  def initialize(money)
    @money = money
  end

  def add_money(value)
    self.money += value
  end

  def take_money(value)
    raise ArgumentError, "You don't have enough money! See you soon." if money < value

    self.money -= value
  end

  private

  attr_writer :money
end
