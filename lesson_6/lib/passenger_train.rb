class PassengerTrain < Train
  def hitch_wagons(wagon)
    raise 'The type of carriage and train does not match!' unless wagon.type == :passenger

    super
  rescue RuntimeError => e
    puts "ERROR: #{e.message}"
  end
end
