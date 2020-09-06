class Route
  attr_accessor :stations
  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    puts "Created route #{stations.first.name} - #{stations.last.name}"
  end

  def add_station(station)
    stations.insert(-2, station)
    puts "Added station #{station.name} to route #{stations.first.name} - #{stations.last.name}"
  end

  def remove_station(station)
    raise 'destinations must not be changed!' if [stations.first, stations.last].include?(station)

    delete_station_from_route(station)
  rescue RuntimeError => e
    puts "ERROR: #{e.message}"
  end

  def delete_station_from_route(station)
    stations.delete(station)
    puts "Station #{station.name} was removed from route #{stations.first.name} - #{stations.last.name}"
  end

  def show_stations
    puts "Stations along the route #{stations.first.name} - #{stations.last.name}:"
    stations.each { |station| puts station.name }
  end

  def to_s
    "Route #{stations[0].name} - #{stations[-1].name}"
  end
end
