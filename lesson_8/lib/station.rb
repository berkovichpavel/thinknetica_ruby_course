require_relative 'instance_counter'
require_relative 'valid'

class Station
  include InstanceCounter
  include Valid

  attr_accessor :train_list
  attr_accessor :name

  @@stations = [] # rubocop:disable Style/ClassVars

  def initialize(name)
    @name = name
    @train_list = []
    validate!
    register_instance
    @@stations << self
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
  end

  def send_train(train)
    train_list.delete(train)
  end

  def show_train_list(type = false)
    raise "No trains at the station #{name}!" if train_list.size.zero?

    type ? show_train_with_condition(type) : show_train_without_condition
  rescue RuntimeError => e
    puts "ERROR: #{e.message}"
  end

  def show_train_with_condition(type)
    puts "Trains at station #{name} of type #{type}:"
    block_iterate_trains do |train|
      puts "##{train.serial_number} #{train.class}. Wagons amount: #{train.wagons.size}" if train.type == type
    end
  end

  def show_train_without_condition
    puts "All trains at station #{name}:"
    block_iterate_trains do |train|
      puts "##{train.serial_number} #{train.class}. Wagons amount: #{train.wagons.size}"
    end
  end

  def block_iterate_trains(&block)
    raise 'There are no trains at the station' if train_list.empty?

    train_list.each { |train| block.call(train) }
  rescue RuntimeError => e
    puts "ERROR: #{e.message}"
  end

  private

  def validate!
    raise 'Station name cannot be empty, please try again.' if name.empty?
  end
end
