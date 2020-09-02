class PassengerWagon < Wagon
  attr_reader :total
  attr_accessor :filled

  def initialize(total_seat_number = 30)
    @type = :passenger
    super(total_seat_number)
  end

  def take_a_seat
    take_a_place(1, 'No free places')
  end
end
