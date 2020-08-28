class PassengerTrain < Train
  def hitch_wagons(wagon)
    if wagon.type == :passenger
      super
    else
      puts 'The type of carriage and train does not match!'
    end
  end
end
