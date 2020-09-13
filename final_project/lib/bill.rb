require_relative 'user_interaction'

class Bill
  attr_reader :money

  def initialize(money)
    @money = money
  end

  def add_money(value)
    self.money += value
  end

  def take_money(value)
    raise ArgumentError, UserInteraction.errors['NO_MONEY'] if money < value

    self.money -= value
  end

  private

  attr_writer :money
end
