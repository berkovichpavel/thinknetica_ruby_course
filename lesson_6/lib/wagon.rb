require_relative 'company_name'
require_relative 'instance_counter'

class Wagon
  include CompanyName
  include InstanceCounter

  attr_accessor :type, :number
  @@serial_number = 1

  def initialize
    @number = @@serial_number
    @@serial_number += 1
    register_instance
    add_company_name
  end

  def add_company_name
    print 'Add company name to Wagon: '
    self.company_name = STDIN.gets.chomp
  end
end
