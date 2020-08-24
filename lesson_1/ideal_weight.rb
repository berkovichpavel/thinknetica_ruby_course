puts "Введите имя"
name = gets.chomp
puts "Введите рост"
growth =gets.chomp

if (growth - 110) * 1.15 > 0
  puts "#{name}, Ваш результат #{growth}."
else
  puts "#{name}, Ваш вес уже оптимальный."
end