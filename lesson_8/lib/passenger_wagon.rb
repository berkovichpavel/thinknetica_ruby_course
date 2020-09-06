class PassengerWagon < Wagon
  attr_reader :total
  attr_accessor :filled

  def initialize(total_seat_number = 30)
    @type = :passenger
    super(total_seat_number)
  end

  def take_a_place(message = 'No free places')
    super(1, message)
  end
end
