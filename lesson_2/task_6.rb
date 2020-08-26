purchased_goods = {}

loop do
  print 'Enter a name or "stop": '
  name = gets.chomp.strip.downcase
  break if name == 'stop'

  print 'Enter a price: '
  price = gets.chomp.to_f
  print 'Enter amount: '
  amount = gets.chomp.to_f
  if purchased_goods[name].nil?
    purchased_goods[name] = { price: price, amount: amount }
  else
    puts 'This product was purchased'
  end
end
amount_of_purchases = 0
purchased_goods.each_value { |value| amount_of_purchases += value[:price] * value[:amount] }

puts purchased_goods.to_s
puts "Amount of purchases: #{amount_of_purchases}"
