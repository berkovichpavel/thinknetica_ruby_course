class PassengerWagon < Wagon
  attr_reader :total
  attr_accessor :filled

  def initialize(total_seat_number = 30)
    @type = :passenger
    super(total_seat_number)
  end

  def take_a_seat
    raise 'No free places' if filled?

    self.filled += 1
  rescue RuntimeError => e
    puts "ERROR: #{e.message}"
  end
end
