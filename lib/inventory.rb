class Inventory
  def initialize(products)
    @inventory = products.map { |product| [product.code.to_sym, product] }.to_h
  end

  def find(code)
    @inventory[code.to_sym]
  end

  def products_count
    @inventory.size
  end

  def products
    @inventory.values
  end

  def valid_codes
    products.map(&:code)
  end

  def to_a
    products.map(&:to_a)
  end

  def to_s
    products.map(&:to_s)
  end
end
