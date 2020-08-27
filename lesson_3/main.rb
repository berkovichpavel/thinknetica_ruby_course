require_relative 'train'
require_relative 'station'
require_relative 'route'

station_vitebsk = Station.new('Vitebsk')
station_soligorsk = Station.new('Soligorsk')
station_grodno = Station.new('Grodno')
station_mogilev = Station.new('Mogilev')
station_slusk = Station.new('Slusk')
station_gomel = Station.new('Gomel')

route_vit_sol = Route.new(station_vitebsk, station_soligorsk)
route_vit_sol.add_station(station_grodno)
route_vit_sol.add_station(station_gomel)
route_vit_sol.add_station(station_mogilev)
route_vit_sol.add_station(station_slusk)
route_vit_sol.show_stations
route_vit_sol.remove_station(station_mogilev)
route_vit_sol.show_stations

puts "\n\n\n\n"

train1 = Train.new('12F45k', 'passenger', 5)
train2 = Train.new('543L99J6', 'cargo', 40)
train3 = Train.new('ip093g', 'passenger', 12)
train4 = Train.new('ytf04w', 'cargo', 100)

train1.add_route(route_vit_sol)
train1.move_to_the_next_station
train1.move_to_the_next_station

station_gomel.show_train_list
station_grodno.show_train_list

train1.move_to_the_next_station
train1.move_to_the_next_station
train1.move_to_the_next_station
train1.move_to_the_previous_station

puts "\n\n\n\n"

my_station = Station.new('Berdacha')
my_station.train_reception(train2)
my_station.train_reception(train3)
my_station.train_reception(train4)

my_station.show_train_list('cargo')
my_station.show_train_list('passenger')
train1.stations_around

my_station.train_reception(train1)
station_slusk.show_train_list
train1.stations_around

puts "\n\n\n\n"

train1.pick_up_speed
train1.hitch_wagons
train1.brake
train1.hitch_wagons
train1.hitch_wagons
train1.wagons_amount
train1.unhitch_wagons
train1.wagons_amount
train1.pick_up_speed(50)
train1.unhitch_wagons
