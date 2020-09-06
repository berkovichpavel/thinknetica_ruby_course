require_relative 'route'
require_relative 'wagon'
require_relative 'company_name'
require_relative 'instance_counter'
require_relative 'valid'

class Train
  include CompanyName
  include InstanceCounter
  include Valid
  attr_accessor :speed, :wagons, :serial_number, :type, :route, :current_station
  @@trains = {} # rubocop:disable Style/ClassVars
  VALID_TRAIN_NUMBER = /^[\d\w]{3}-?[\d\w]{2}$/i.freeze
  TRAINS_TYPES = %w[cargo passenger].freeze

  def initialize(serial_number, type)
    @serial_number = serial_number
    @type = type
    @speed = 0
    @wagons = []
    add_company_name
    validate!
    @@trains[self.serial_number] = self
    register_instance
    puts "Train ##{self.serial_number} created. Type: #{self.type}. Number of wagons: #{wagons.size}."
  end

  def add_company_name
    print "Add company name for #{self.class} #{serial_number}: "
    self.company_name = STDIN.gets.chomp
  end

  def self.find(serial_number)
    @@trains[serial_number]
  end

  def pick_up_speed(new_speed = 20)
    self.speed = new_speed
  end

  def brake
    self.speed = 0
  end

  def hitch_wagons(wagon)
    raise 'To hitch the carriage, you must stop!' unless speed.zero?

    wagons << wagon
  end

  def unhitch_wagons(wagon)
    raise 'To unhitch the carriage, you must stop!' unless speed.zero?
    raise 'You cannot unhook the wagon if it is not there' unless wagons.size.positive?

    wagons.delete(wagon)
  end

  def show_wagons
    wagons.each_with_index { |wagon, index| puts "#{index + 1}. Serial wagon number: #{wagon.number}" }
  end

  def add_route(route)
    route.stations.first.send_train(self) if route
    self.route = route
    route.stations.first.train_reception(self)
    self.current_station = route.stations.first
  end

  def move_to_the_next_station # rubocop:disable Metrics/AbcSize
    raise 'can\'t move without a route' if route.nil?
    if current_station == route.stations.last
      raise 'You have already arrived at the terminal station and you have nowhere to go!'
    end

    current_station.send_train(self)
    self.current_station = route.stations[route.stations.index(current_station) + 1]
    current_station.train_reception(self)
  end

  def move_to_the_previous_station # rubocop:disable Metrics/AbcSize
    raise 'can\'t move without a route' if route.nil?
    if current_station == route.stations.first
      raise 'You have already arrived at the initial station and you have nowhere to go!'
    end

    current_station.send_train(self)
    self.current_station = route.stations[route.stations.index(current_station) - 1]
    current_station.train_reception(self)
  end

  def stations_around # rubocop:disable Metrics/AbcSize
    raise 'can\'t move without a route' if route.nil?

    station_index = route.stations.index(current_station)
    puts "Now the train is at the station #{current_station.name}."
    puts "Previous station - #{route.stations[station_index - 1].name}." if station_index != 0
    puts "Next station - #{route.stations[station_index + 1].name}." if station_index != route.stations.size - 1
  end

  def block_iterate_wagons(&block)
    raise 'There are no vagons at the train' if wagons.empty?

    wagons.each { |wagon| block.call(wagon) }
  end

  private

  def validate!
    raise 'The train number does not match the pattern (xxxxx or xxx-xx)' if serial_number !~ VALID_TRAIN_NUMBER
    raise 'Trains don\'t have this type yet' unless TRAINS_TYPES.include?(type.to_s)
  end
end
