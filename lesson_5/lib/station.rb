require_relative 'instance_counter'

class Station
  include InstanceCounter
  attr_accessor :train_list
  attr_accessor :name
  @@stations = []
  def initialize(name)
    @name = name
    @train_list = []
    @@stations << self
    puts "Station with name #{name} built"
    register_instance
  end

  def self.all
    puts '------------------'
    puts '   All stations   '
    puts '------------------'
    @@stations.each_with_index do |station, index|
      puts "#{index + 1}. #{station.name}"
    end
    puts '------------------'
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
    if train_list.size.zero?
      puts "No trains at the station #{name}!"
    elsif type
      puts "Trains at station #{name} of type #{type}:"
      train_list.each { |train| puts train.serial_number if train.type == type }
    else
      puts "All trains at station #{name}:"
      train_list.each { |train| puts train.serial_number }
    end
  end
end
