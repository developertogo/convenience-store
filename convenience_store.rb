require_relative 'lib/order.rb'
require_relative 'lib/checkout.rb'
require_relative 'lib/store.rb'
require_relative 'lib/product.rb'
require_relative 'lib/item.rb'

# Print variables
def prompt
  print '> '
end

def newline
  puts "\n"
end

counties = [
  County.new(name: 'Broward', tax: 7, markup_price: 30),
  County.new(name: 'Miami-Dade', tax: 6, markup_price: 25),
  County.new(name: 'Palm Beach', tax: 8, markup_price: 30)
]
products = [
  Product.new('AP1', 'Salix', 'Apple', 30.00, 100),
  Product.new('OR1', 'Sunkist', 'Orange', 30.00, 100),
  Product.new('PI0', 'Dole', 'Pineapple', 30.00, 100)
]
store = Store.new('St. Bernard Corner', counties, products)

order = Order.new(store)
checkout = Checkout.new(store)

def fill_order(order)
  order.add_item('AP1', 'Broward', 100)
  order.add_item('OR1', 'Miami-Dade', 100)
  order.add_item('PI0', 'Palm Beach', 100)
  order
end

option = 0
loop do
  puts "
    Welcome to #{store.name}

    1. Fill order
    2. Order detail
    3. Clear order
    4. Product list
    5. County list
    6. Total purchase
    7. Total profit
    8. Exit
  "
  prompt

  option = gets.chomp
  temp = option.to_i
  option = temp.zero? ? option : temp
  newline

  case option
  when 1, 'f'
    order = fill_order(order)
    checkout.add(order)
    puts 'Done'
  when 2, 'd'
    checkout.show
  when 3, 'c'
    puts 'Are you sure you\'d like to clear the order? [Y/n]'
    checkout.clear; order.clear if gets.chomp == 'Y'
  when 4, 'r'
    store.show_products
  when 5, 'o'
    store.show_counties
  when 6, 't'
    puts "Total: #{checkout.total}"
  when 7, 'p'
    puts "Profit: #{checkout.profit}"
  when 8, 'e', 'q'
    puts 'Are you sure you\'d like to exit? [Y/n]'
    break if gets.chomp == 'Y'
  else
    puts 'Invalid option.'
    puts 'Enter option # or option 1st letter.'
    puts 'Please try again...'
  end
end

puts "\nThank you for shopping at #{store.name}!"
puts "Come back again...\n\n"
