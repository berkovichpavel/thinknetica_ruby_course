class CargoWagon < Wagon
  attr_reader :total
  attr_accessor :filled

  def initialize(total_volume)
    @type = :cargo
    super(total_volume)
  end

  def take_a_volume(volume = 20)
    raise 'No free volume' if total - filled < volume

    self.filled += volume
  rescue RuntimeError => e
    puts "ERROR: #{e.message}"
  end
end
