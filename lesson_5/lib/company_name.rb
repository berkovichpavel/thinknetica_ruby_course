module CompanyName
  attr_reader :company_name

  def add_company_name
    print 'Enter a company name:'
    @company_name = gets.chomp
  end

  def print_company_name
    puts "Company name: #{company_name}"
  end

  private

  attr_writer :company_name
end
