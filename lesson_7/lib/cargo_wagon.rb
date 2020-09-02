class CargoWagon < Wagon
  attr_reader :total
  attr_accessor :filled

  def initialize(total_volume)
    @type = :cargo
    @total = total_volume
    @filled = 0
    super()
  end

  def take_a_volume(volume = 20)
    raise 'No free volume' if total - filled < volume

    self.filled += 20
  rescue RuntimeError => e
    puts "ERROR: #{e.message}"
  end

  def free
    total - filled
  end




end
