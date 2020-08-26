fib_arr = [0, 1]

fib_arr << fib_arr[-1] + fib_arr[-2] while (fib_arr[-1] < 100) && (fib_arr[-1] + fib_arr[-2] <= 100)

puts fib_arr.to_s
