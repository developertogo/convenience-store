require_relative '../lib/checkout.rb'
require_relative '../lib/county.rb'
require_relative '../lib/store.rb'
require_relative '../lib/product.rb'
require_relative '../lib/item.rb'

describe Checkout do
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

  subject(:checkout) do
    Checkout.new(store)
  end

  describe '#add' do
    it 'add an order' do
      order = Order.new(store)
      checkout.add(order)
      expect(checkout.orders_count).to eq(1)
    end
  end

  describe '#clear' do
    it 'invokes checkout class to clear order' do
      expect_any_instance_of(Checkout).to receive(:clear)
      checkout.clear
    end
  end

  describe '#total' do
    context 'when checkout has empty order' do
      it 'returns 0' do
        expect(checkout.total).to eq(0)
      end
    end

    context 'when checkot has not empty order' do
      it 'returns a nonzero total' do
        order = Order.new(store)
        order.add_item('AP1', 'Broward', 100)
        order.add_item('OR1', 'Miami-Dade', 100)

        checkout.add(order)

        items = [
          Item.new('AP1', 'Broward', 100, 30.00),
          Item.new('OR1', 'Miami-Dade', 100, 30.00)
        ]
        items.each { |item| order.store.accounting.purchased_price_by_item(item) }

        total = items.inject(0.0) { |sum, item| sum + item.purchased_price }.round(2)

        expect(checkout.total).to eq(total)
      end
    end
  end

  describe '#profit' do
    context 'when order is empty' do
      it 'returns 0' do
        expect(checkout.profit).to eq(0)
      end
    end

    context 'when order is not empty' do
      it 'returns a nonzero profit' do
        order = Order.new(store)
        order.add_item('AP1', 'Broward', 100)
        order.add_item('OR1', 'Miami-Dade', 100)

        checkout.add(order)

        items = [
          Item.new('AP1', 'Broward', 100, 30.00),
          Item.new('OR1', 'Miami-Dade', 100, 30.00)
        ]
        items.each { |item| order.store.accounting.purchased_price_by_item(item) }
        profit = items.inject(0.0) { |gain, item| gain + order.store.accounting.profit_by_item(item) }.round(2)

        profit = 0.0
        items.each do |item|
          county = order.store.accounting.find_by_name(item.county_name)
          profit += item.quantity * (item.unit_price - item.unit_price * (1 - (county.markup_price / 100.0)))
        end

        expect(checkout.profit).to eq(profit)
      end
    end
  end
end
