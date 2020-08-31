require_relative 'lib/controller'

# controller = Controller.new
# controller.run
#
t = Train.new('hgfd345', 'cargo')
puts Train.find('hgfd345')

s1 = Station.new('fg')
s2 = Station.new('fgg')
puts Station.all

w1 = Wagon.new
w2 = Wagon.new
w3 = Wagon.new

w1.print_company_name
w2.print_company_name
w3.print_company_name

puts Train.instances
puts Station.instances
puts Wagon.instances
