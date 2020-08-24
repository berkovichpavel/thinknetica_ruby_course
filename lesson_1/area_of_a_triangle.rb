puts 'Введите основание треугольника'
base = gets.chomp.to_f
puts 'Введите высту'
height = gets.chomp.to_f

puts "Площадь треугольника = #{(0.5 * base * height).round(3)}."
