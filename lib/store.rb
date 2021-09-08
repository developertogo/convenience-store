require_relative 'accounting'
require_relative 'inventory'

class Store
  attr_reader :name, :accounting, :inventory

  def initialize(name, counties, products)
    @name = name
    @accounting = Accounting.new(counties)
    @inventory = Inventory.new(products)
  end

  def show_products
    puts 'code, brand_name, name, quantity, cost_price'
    puts @inventory.products.sort_by(&:code).each(&:to_s)
  end

  def show_counties
    @accounting.show_counties
  end
end
