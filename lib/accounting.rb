require_relative 'county'

class Accounting
  def initialize(counties)
    @counties = counties.map { |county| [county.name.to_sym, county] }.to_h
  end

  def find_by_name(name)
    @counties[name.to_sym]
  end

  def counties_count
    @counties.size
  end

  def counties
    @counties.values
  end

  def counties_names
    counties.map(&:name)
  end

  def purchased_price_by_item(item)
    0 unless item.quantity.positive?

    county = @counties[item.county_name.to_sym]
    item.purchased_price = item.unit_price * (1 + (county.markup_price / 100.0)) * (1 + (county.tax / 100.0)) * item.quantity
  end

  def profit_by_item(item)
    raise 'must set item purchased_price' unless item.purchased_price >= 0

    county = @counties[item.county_name.to_sym]
    pre_tax_price = item.purchased_price / (1 + (county.tax / 100.0))
    pre_tax_price - (item.unit_price * item.quantity)
  end

  def total_by_orders(orders)
    orders.inject(0.0) { |total, order| total + order.total }.round(2)
  end

  def profit_by_orders(orders)
    orders.inject(0.0) { |profit, order| profit + order.profit }.round(2)
  end

  def to_a
    counties.map(&:to_a)
  end

  def to_s
    counties.map(&:to_s)
  end

  def show_counties
    puts 'name, tax,  mark-up_price'
    puts counties.sort_by(&:name).each(&:to_s)
  end
end
