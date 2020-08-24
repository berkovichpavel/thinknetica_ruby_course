puts 'Решим квадратное уравнение, введите следующие коэффициенты:'
print 'a: '
a = gets.chomp.to_f
print 'b: '
b = gets.chomp.to_f
print 'c: '
c = gets.chomp.to_f

d = (b**2) - (4 * a * c)

if d > 0
  d_sqrt = Math.sqrt(d)
  x1 = (-b + d_sqrt)/(2 * a)
  x2 = (-b - d_sqrt)/(2 * a)
  puts "Дискриминант = #{d}, x1 = #{x1}, x2 = #{x2}"
elsif d == 0
  x = -b/(2 * a)
  puts "Дискриминант = #{d}, корень = #{x}"
elsif d < 0
  puts 'Нет рациональных корней'
end