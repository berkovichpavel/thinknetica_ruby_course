require_relative 'instance_counter'
require_relative 'valid'

class Station
  include InstanceCounter
  include Valid

  attr_accessor :train_list
  attr_accessor :name
  @@stations = []

  def initialize(name)
    @name = name
    @train_list = []
    validate!
    register_instance
    @@stations << self
    puts "Station with name #{name} built"
  end

  def self.all
    @@stations.to_s
  end

  def train_reception(train)
    if train.route
      train.route = nil unless train.route.stations.include?(self)
    end
    train.current_station = self
    train_list << train
    puts "Train #{train.serial_number} arrived at station #{name}"
  end

  def send_train(train)
    train_list.delete(train)
    puts "Train #{train.serial_number} departed from station #{name}"
  end

  def show_train_list(type = nil)
    raise "No trains at the station #{name}!" if train_list.size.zero?

    if type
      puts "Trains at station #{name} of type #{type}:"
      train_list.each { |train| puts train.serial_number if train.type == type }
    else
      puts "All trains at station #{name}:"
      train_list.each { |train| puts train.serial_number }
    end
  rescue RuntimeError => e
    puts "ERROR: #{e.message}"
  end

  private

  def validate!
    raise 'Station name cannot be empty, please try again.' if name.empty?
  end
end
