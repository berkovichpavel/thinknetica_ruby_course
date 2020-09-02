class CargoWagon < Wagon
  attr_reader :total
  attr_accessor :filled

  def initialize(total_volume)
    @type = :cargo
    super(total_volume)
  end

  def take_a_volume(volume = 20)
    take_a_place(volume, 'No free volume')
  end
end
