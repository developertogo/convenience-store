class Product
  attr_reader :code, :brand_name, :name, :cost_price, :quantity

  def initialize(code, brand_name, name, cost_price, quantity)
    @code = code
    @brand_name = brand_name
    @name = name
    @cost_price = cost_price
    @quantity = quantity
    # For future usage
    # @quantity_on_hand
    # @quantity_available
    # @quantity_allocated
  end

  def to_a
    [@code, @brand_name, @name, @cost_price, @quantity]
  end

  def to_s
    "#{@code}, #{@brand_name}, #{@name},  #{@cost_price} #{@quantity}"
  end
end
