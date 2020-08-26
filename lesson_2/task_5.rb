print 'Enter a day: '
day = gets.chomp.to_i
print 'Enter a month: '
month = gets.chomp.to_i
print 'Enter a year: '
year = gets.chomp.to_i

days_in_a_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
days_in_a_month[1] = 29 if (year % 400).zero? || ((year % 4).zero? && year % 100 != 0)

serial_number = 0
(0...month - 1).each { |i| serial_number += days_in_a_month[i] }
serial_number += day
puts serial_number
