class Item
  attr_reader :code
  attr_accessor :county_name, :quantity, :unit_price, :purchased_price

  def initialize(code, county_name, quantity, unit_price)
    @code = code
    @county_name = county_name
    @quantity = quantity
    @unit_price = unit_price
    @purchased_price = -1
  end

  def to_a
    [@code, @county_name, @quantity, @unit_price, @purchased_price]
  end

  def to_s
    "#{@code}, #{@county_name}, #{@quantity},  #{@unit_price}, #{@purchased_price}"
  end
end
