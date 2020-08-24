puts 'Введите 3 стороны прямоугольника через Enter'
first = gets.chomp.to_f
second = gets.chomp.to_f
third = gets.chomp.to_f

if first > second && first > third
  side1 = second
  side2 = third
  hypotenuse = first
elsif second > third
  side1 = first
  side2 = third
  hypotenuse = second
else
  side1 = first
  side2 = second
  hypotenuse = third
end

hypotenuse_equality = Math.sqrt(side1**2 + side2**2) == hypotenuse

if first == second && first == third
  puts 'Треугольник равнобедренный и равносторонний!'
elsif first == second || first == third || third == second
  if hypotenuse_equality
    puts 'Треугольник равносторонний и прямоугольный'
  else
    puts 'Треугольник равносторонний'
  end
elsif hypotenuse_equality
  puts 'Треугольник прямоугольный'
else
  puts 'Треугольник никакой'
end
