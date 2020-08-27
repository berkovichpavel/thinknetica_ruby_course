require_relative 'train'

class Station
  attr_accessor :train_list
  attr_reader :name
  def initialize(name)
    @name = name
    @train_list = []
    puts "Station with name #{name} built"
  end

  def train_reception(train)
    unless train.route.nil?
      train.route = nil unless train.route.stations.include?(self)
      train.current_station&.send_train(train)
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
