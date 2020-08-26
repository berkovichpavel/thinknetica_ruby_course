fib_arr = [0, 1]

while (fib_arr[-1] < 100) && (fib_arr[-1] + fib_arr[-2] <= 100) do 
	fib_arr << fib_arr[-1] + fib_arr[-2] 
end 

puts fib_arr.to_s
