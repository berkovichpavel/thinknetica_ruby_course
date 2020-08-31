class CargoTrain < Train
  def hitch_wagons(wagon)
    if wagon.type == :cargo
      super
    else
      puts 'The type of carriage and train does not match!'
    end
  end
end
