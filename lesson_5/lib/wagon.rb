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
    add_company_name
    print_company_name
    register_instance
  end
end
