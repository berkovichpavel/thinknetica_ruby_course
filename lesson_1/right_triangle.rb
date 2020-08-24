puts "Введите 3 стороны прямоугольника через Enter"
first = gets.chomp.to_f
second = gets.chomp.to_f
third = gets.chomp.to_f

if first > second && first > third
  hypotenuse_equality = Math.sqrt(third**2 + second**2) == first
elsif second>third
  hypotenuse_equality = Math.sqrt(third**2 + first**2) == second
else
  hypotenuse_equality = Math.sqrt(second**2 + first**2) == third
end

if first == second && first == third
  puts "Треугольник равнобедренный и равносторонний!"
elsif (first == second || first == third || third == second)
  if (hypotenuse_equality)
    puts "Треугольник равносторонний и прямоугольный"
  else
    puts "Треугольник равносторонний"
  end
elsif hypotenuse_equality
  puts "Треугольник прямоугольный"
else
  puts "Треугольник никакой"
end