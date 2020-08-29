require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

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

  def run
    loop do
      print_menu
      choice = gets.chomp.to_i
      break if choice.zero?

      case choice
      when 1
        create_stations
      when 2
        create_trains
      when 3
        create_route
      when 4
        assign_route
      when 5
        add_wagons
      when 6
        remove_wagons
      when 7
        move_the_train
      when 8
        view_station_and_train_list
      end
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
    route_choice.between?(1, routes.size)? routes[route_choice - 1] : nil
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
      puts "Indicate the type of train. Available trains: #{TRAINS_TYPES.keys}"
      type = gets.chomp.to_sym
      puts 'Enter the train serial number'
      serial_number = gets.chomp
      if TRAINS_TYPES.keys.include?(type)
        trains << TRAINS_TYPES[type].new(serial_number, type)
      else
        puts "Couldn't create a wagon! Unknown type #{type}"
      end
      puts 'Want create train(1/0)?'
      choice = STDIN.gets.chomp.to_i
      break if choice.zero?
    end
  end

  def create_route
    puts 'When creating a route, select the start and end station and enter their number via the enter.'
    show_all_stations
    first_station = STDIN.gets.chomp.to_i
    second_station = STDIN.gets.chomp.to_i
    if first_station.between?(1, stations.size) && second_station.between?(1, stations.size)
      new_route = Route.new(stations[first_station - 1], stations[second_station - 1])
    else
      puts 'wrong stations!'
      return
    end
    add_or_delete_middle_stations(new_route)
    routes << new_route
  end

  def add_or_delete_middle_stations(route)
    loop do
      puts 'Want to add or delete stations to the middle(1/-1)?'
      choice = STDIN.gets.chomp.to_i
      break unless choice == 1 || choice == -1

      puts 'Select number of station.'
      show_all_stations
      number = STDIN.gets.chomp.to_i
      choice == 1 ? route.add_station(stations[number - 1]) : route.remove_station(stations[number - 1])
    end
  end

  def assign_route
    train = select_train
    if train.nil?
      puts 'You entered incorrect data!'
      nil
    else
      route = select_route
      if route.nil?
        puts 'You entered incorrect data!'
        nil
      else
        train.add_route(route)
      end
    end
  end

  WAGONS_TYPES = { cargo: CargoWagon, passenger: PassengerWagon }.freeze

  def add_wagons
    train = select_train
    if train.nil?
      puts 'You entered incorrect data!'
      nil
    else
      loop do
        wagon = WAGONS_TYPES[train.type.to_sym].new
        train.hitch_wagons(wagon)
        puts 'Would you like to add new wagon(1/0)?'
        yes_no = STDIN.gets.chomp.to_i
        break if yes_no.zero?
      end
    end
  end

  def remove_wagons
    train = select_train
    if train.nil?
      puts 'You entered incorrect data!'
      nil
    else
      loop do
        wagon = select_wagon(train)
        if wagon.nil?
          puts 'You entered incorrect data!'
          return
        else
          train.unhitch_wagons(wagon)
        end
        puts 'Would you like to remove wagon(1/0)?'
        yes_no = STDIN.gets.chomp.to_i
        break if yes_no.zero?
      end
    end
  end

  def move_the_train
    train = select_train
    if train.nil?
      puts 'You entered incorrect data!'
      nil
    else
      puts 'Where do you want to go forward or backward?(1/-1)'
      choice = STDIN.gets.chomp.to_i
      choice.positive? ? train.move_to_the_next_station : train.move_to_the_previous_station
    end
  end

  def view_station_and_train_list
    show_all_stations
    puts 'Would you like to see train list at the specific station(1/0)?'
    choice = STDIN.gets.chomp.to_i
    return if choice.zero?

    station = select_station
    if station.nil?
      puts 'You entered incorrect data!'
      nil
    else
      station = stations[choice - 1]
      station.show_train_list
    end
  end
end
