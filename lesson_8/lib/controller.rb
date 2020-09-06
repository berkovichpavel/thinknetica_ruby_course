require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'station'
require_relative 'route'

class Controller
  attr_accessor :stations, :trains, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def show_all_stations
    puts 'All stations:'
    stations.each_with_index { |station, index| puts "#{index + 1}. #{station.name}" }
  end

  def show_all_trains
    puts 'All trains:'
    trains.each_with_index { |train, index| puts "#{index + 1}. #{train.serial_number}" }
  end

  def show_all_routes
    puts 'All routes:'
    routes.each_with_index { |route, index| puts "#{index + 1}. #{route}\n\n" }
  end

  USER_CHOICES = {
    1 => :create_stations,
    2 => :create_trains,
    3 => :create_route,
    4 => :assign_route,
    5 => :add_wagons,
    6 => :remove_wagons,
    7 => :move_the_train,
    8 => :view_station_and_train_list,
    9 => :display_wagons,
    10 => :take_up_space
  }.freeze

  def run
    loop do
      print_menu
      choice = gets.chomp.to_i
      break if choice.zero? || !choice.between?(1, 10)

      # public_send()
      method(USER_CHOICES[choice]).call
    end
  end

  private

  def print_menu
    string = File.open('./data/menu.txt', 'r', &:read)
    puts string
  end

  def select_train
    puts 'Select the train'
    show_all_trains
    choice = STDIN.gets.chomp.to_i
    choice.between?(1, trains.size) ? trains[choice - 1] : nil
  end

  def select_route
    puts 'Select the route'
    show_all_routes
    route_choice = STDIN.gets.chomp.to_i
    route_choice.between?(1, routes.size) ? routes[route_choice - 1] : nil
  end

  def select_station
    puts 'Choose a station number'
    choice = STDIN.gets.chomp.to_i
    choice.between?(1, stations.size) ? stations[choice - 1] : nil
  end

  def select_wagon(train)
    puts 'Select the wagon'
    train.show_wagons
    choice = STDIN.gets.chomp.to_i
    choice.between?(1, train.wagons.size) ? train.wagons[choice - 1] : nil
  end

  def create_stations
    loop do
      print 'Enter a station name: '
      name = STDIN.gets.chomp
      stations << Station.new(name)
      puts 'Want create station(1/0)?'
      choice = STDIN.gets.chomp.to_i
      break if choice.zero?
    end
  end

  TRAINS_TYPES = { cargo: CargoTrain, passenger: PassengerTrain }.freeze

  def create_trains
    loop do
      create_train
      puts 'Want create train(1/0)?'
      choice = STDIN.gets.chomp.to_i
      break if choice.zero?
    end
  end

  def create_train
    type = indicate_train_type
    puts 'Enter the train serial number'
    serial_number = gets.chomp
    train = TRAINS_TYPES[type].new(serial_number, type)
    trains << train
  end

  def indicate_train_type
    puts "Indicate the type of train. Available trains: #{TRAINS_TYPES.keys}"
    type = gets.chomp.to_sym
    raise 'Incorrect type!' unless TRAINS_TYPES.keys.include?(type)

    type
  rescue RuntimeError => e
    mistakes ||= 0
    puts "ERROR: #{e.message}. Try again"
    mistakes += 1
    retry if mistakes <= 3
    puts 'You are hopeless :('
  end

  def create_route
    main_stations = select_main_route_stations
    new_route = Route.new(stations[main_stations[0]], stations[main_stations[1]])
    add_or_delete_middle_stations(new_route)
    routes << new_route
  end

  def select_main_route_stations
    puts 'When creating a route, select the start and end station and enter their number via the enter.'
    show_all_stations
    first_station = STDIN.gets.chomp.to_i
    second_station = STDIN.gets.chomp.to_i
    raise 'wrong stations!' unless correct_stations?(first_station, second_station)

    [first_station - 1, second_station - 1]
  rescue RuntimeError => e
    puts "ERROR: #{e.message}"
  end

  def correct_stations?(*args)
    answer = true
    args.each { |station| answer &&= station.between?(1, stations.size) }
    answer
  end

  def add_or_delete_middle_stations(route)
    loop do
      puts 'Want to add or delete stations to the middle(1/-1)?. Enter other key to exit.'
      choice = STDIN.gets.chomp.to_i
      break unless [1, -1].include?(choice)

      add_or_delete_middle_station(route, choice)
    end
  end

  def add_or_delete_middle_station(route, choice)
    puts 'Select number of station.'
    show_all_stations
    number = STDIN.gets.chomp.to_i
    choice == 1 ? route.add_station(stations[number - 1]) : route.remove_station(stations[number - 1])
  end

  def assign_route
    train = select_train
    raise 'You entered incorrect data!' if train.nil?

    route = select_route
    raise 'You entered incorrect data!' if route.nil?

    train.add_route(route)
  rescue RuntimeError => e
    puts "ERROR: #{e.message}"
  end

  WAGONS_TYPES = { cargo: CargoWagon, passenger: PassengerWagon }.freeze

  def add_wagons
    train = select_train
    raise 'You entered incorrect data!' if train.nil?

    loop do
      add_wagon_to_train(train)
      puts 'Would you like to add new wagon(1/0)?'
      yes_no = STDIN.gets.chomp.to_i
      break if yes_no.zero?
    end
  rescue RuntimeError => e
    puts "ERROR: #{e.message}"
  end

  def add_wagon_to_train(train)
    print 'Enter a capacity of wagon: '
    capacity = STDIN.gets.chomp.to_i
    wagon = WAGONS_TYPES[train.type.to_sym].new(capacity)
    train.hitch_wagons(wagon)
  end

  def remove_wagons
    train = select_train
    raise 'You entered incorrect data!' if train.nil?

    loop do
      remove_wagon(train)
      puts 'Would you like to remove wagon(1/0)?'
      yes_no = STDIN.gets.chomp.to_i
      break if yes_no.zero?
    end
  rescue RuntimeError => e
    puts "ERROR: #{e.message}"
  end

  def remove_wagon(train)
    wagon = select_wagon(train)
    raise 'You entered incorrect data!' if wagon.nil?

    train.unhitch_wagons(wagon)
  end

  def move_the_train
    train = select_train
    raise 'You entered incorrect data!' if train.nil?

    puts 'Where do you want to go forward or backward?(1/-1)'
    choice = STDIN.gets.chomp.to_i
    choice.positive? ? train.move_to_the_next_station : train.move_to_the_previous_station
  rescue RuntimeError => e
    puts "ERROR: #{e.message}"
  end

  def view_station_and_train_list
    show_all_stations
    puts 'Would you like to see train list at the specific station(1/0)?'
    choice = STDIN.gets.chomp.to_i
    return if choice.zero?

    station = select_station
    raise 'You entered incorrect data!' if station.nil?
  rescue RuntimeError => e
    puts "ERROR: #{e.message}"
  end

  def display_wagons
    train = select_train
    raise 'You entered incorrect data!' if train.nil?

    train.block_iterate_wagons { |wagon| puts "##{wagon.number} #{wagon.type}  #{wagon.filled}/#{wagon.free}" }
  rescue RuntimeError => e
    puts "ERROR: #{e.message}"
  end

  def take_up_space
    train = select_train
    raise 'You entered incorrect data!' if train.nil?

    wagon = select_wagon(train)
    raise 'You entered incorrect data!' if wagon.nil?

    wagon.class == CargoWagon ? take_a_volume(wagon) : wagon.take_a_place
  rescue RuntimeError => e
    puts "ERROR: #{e.message}"
  end

  def take_a_volume(wagon)
    print 'Enter the volume you want to borrow: '
    choice = STDIN.gets.chomp.to_i
    wagon.take_a_volume(choice)
  end
end
