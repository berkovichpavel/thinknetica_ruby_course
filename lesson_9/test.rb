require_relative 'lib/car'

car = Car.new

car.model = 'BMW x6'
car.serial_number = 'we4-43-y'
car.issue_year = 2005

puts 'All checks passed successfully' if car.valid?

car.model = 'Bentley'
car.model = 'Ford focus'

puts car.model_history.to_s

car.serial_number = 'ghg-t5-u'

puts car.valid? ? 'All checks passed successfully' : 'There is a mistake somewhere'
car.validate!

