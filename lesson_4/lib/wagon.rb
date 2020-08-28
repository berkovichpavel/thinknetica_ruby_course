class Wagon
  attr_accessor :type, :number
  @@serial_number = 1

  def initialize
    @number = @@serial_number
    @@serial_number += 1
  end
end
