require_relative 'company_name'
require_relative 'instance_counter'

class Wagon
  include CompanyName
  include InstanceCounter

  attr_accessor :type, :number, :filled
  attr_reader :total

  @@serial_number = 1

  def initialize(total_capacity = 20)
    @number = @@serial_number
    @@serial_number += 1
    register_instance
    add_company_name
    @total = total_capacity
    @filled = 0
  end

  def add_company_name
    print 'Add company name to Wagon: '
    self.company_name = STDIN.gets.chomp
  end

  def free
    total - filled
  end

  def filled?(value)
    total - filled < value
  end

  protected

  def take_a_place(value, error_message)
    raise error_message if filled?(value)

    self.filled += value
  rescue RuntimeError => e
    puts "ERROR: #{e.message}"
  end
end
