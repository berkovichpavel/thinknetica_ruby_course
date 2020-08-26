arr = []

(10..100).step(5) do |number|
  arr << number
end

puts arr.to_s
