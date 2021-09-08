require_relative 'order'

class Checkout
  def initialize(store)
    @store = store
    @orders = []
  end

  def add(order)
    @orders.push(order)
  end

  def clear
    @orders.clear
  end

  def orders_count
    @orders.size
  end

  def total
    @store.accounting.total_by_orders(@orders)
  end

  def profit
    @store.accounting.profit_by_orders(@orders)
  end

  def show
    @orders.each(&:show)
    puts "grand total: #{total}"
    puts "profit: #{profit}"
  end
end
