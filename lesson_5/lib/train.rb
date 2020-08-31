require_relative 'route'
require_relative 'wagon'
require_relative 'company_name'
require_relative 'instance_counter'

class Train
  include CompanyName
  include InstanceCounter
  attr_accessor :speed, :wagons, :serial_number, :type, :route, :current_station, :wagons
  @@trains = {}

  def initialize(serial_number, type)
    @serial_number = serial_number
    @type = type
    @speed = 0
    @wagons = []
    add_company_name
    @@trains[self.serial_number] = self
    puts "Train ##{self.serial_number} created. Type: #{self.type}. Number of wagons: #{wagons.size}."
    register_instance
  end

  def self.find(serial_number)
    @@trains[serial_number]
  end

  def pick_up_speed(new_speed = 20)
    self.speed = new_speed
  end

  def brake
    self.speed = 0
    puts 'The train slowed down to zero'
  end

  def hitch_wagons(wagon)
    if speed.zero?
      wagons << wagon
      puts "A wagon has been added to train #{serial_number}. Now number of wagons =  #{wagons.size}."
    else
      puts 'To hitch the carriage, you must stop!'
    end
  end

  def unhitch_wagons(wagon)
    if speed.zero?
      if wagons.size.positive?
        wagons.delete(wagon)
        puts "The wagon is uncoupled from train #{serial_number}. Now number of wagons = #{wagons.size}."
      else
        puts 'You cannot unhook the wagon if it is not there'
      end
    else
      puts 'To unhitch the carriage, you must stop!'
    end
  end

  def show_wagons
    wagons.each_with_index { |wagon, index| puts "#{index + 1}. Serial wagon number: #{wagon.number}" }
  end

  def add_route(route)
    self.route.stations.first.send_train(self) if self.route
    self.route = route
    route.stations.first.train_reception(self)
    self.current_station = route.stations.first
    puts "Train # #{serial_number} is assigned route #{route.stations.first.name} - #{route.stations.last.name}"
  end

  def move_to_the_next_station
    if route.nil?
      puts 'can\'t move without a route'
    elsif current_station == route.stations.last
      puts 'You have already arrived at the terminal station and you have nowhere to go!'
    else
      current_station.send_train(self)
      self.current_station = route.stations[route.stations.index(current_station) + 1]
      current_station.train_reception(self)
    end
  end

  def move_to_the_previous_station
    if route.nil?
      puts 'can\'t move without a route'
    elsif current_station == route.stations.first
      puts 'You have already arrived at the initial station and you have nowhere to go!'
    else
      current_station.send_train(self)
      self.current_station = route.stations[route.stations.index(current_station) - 1]
      current_station.train_reception(self)
    end
  end

  def stations_around
    if route.nil?
      puts 'can\'t move without a route'
    else
      station_index = route.stations.index(current_station)
      puts "Now the train is at the station #{current_station.name}."
      puts "Previous station - #{route.stations[station_index - 1].name}." if station_index != 0
      puts "Next station - #{route.stations[station_index + 1].name}." if station_index != route.stations.size - 1
    end
  end
end
