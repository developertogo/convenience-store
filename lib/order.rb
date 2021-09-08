class Order
  attr_reader :items, :store

  @@max_id = 0

  def initialize(store)
    @@max_id += 1
    @id = @@max_id
    @store = store
    @items = []
  end

  def add_by_item(item)
    @items.push(item)
    item
  end

  def add_item(code, county_name, quantity)
    raise "#{code} is not a valid item code" unless valid_code?(code)

    product = @store.inventory.find(code)
    item = Item.new(product.code, county_name, quantity, product.cost_price)
    @store.accounting.purchased_price_by_item(item)
    add_by_item(item)
  end

  def clear
    @items.clear
  end

  def total
    sum = 0.0
    @items.each do |item|
      sum += item.purchased_price if item.purchased_price.positive?
    end
    sum.round(2)
  end

  def profit
    @items.inject(0.0) { |profit, item| profit + store.accounting.profit_by_item(item) }.round(2)
  end

  def show
    puts "order ##{@id}"
    puts 'code, county, quantity, unit_price, purchased_price'
    @items.each do |item|
      puts item
    end
    puts "order total: #{total}"
    puts "order profit: #{profit}"
  end

  private

  def valid_code?(code)
    @store.inventory.valid_codes.include?(code)
  end
end
