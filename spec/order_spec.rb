require_relative '../lib/order.rb'
require_relative '../lib/county.rb'
require_relative '../lib/store.rb'
require_relative '../lib/product.rb'
require_relative '../lib/item.rb'

describe Order do
  subject(:order) do
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

    Order.new(store)
  end

  describe '#add_by_item' do
    it 'add an item' do
      item = Item.new('AP1', 'Broward', 100, 30.00)
      expect(order.add_by_item(item).to_a).to eq(item.to_a)
    end
  end

  describe '#add_item' do
    it 'add an item' do
      item = Item.new('AP1', 'Broward', 100, 30.00)
      order.store.accounting.purchased_price_by_item(item)
      expect(order.add_item('AP1', 'Broward', 100).to_a).to eq(item.to_a)
    end

    it 'add an invalid item' do
      expect { order.add_item('UU1', 'Broward', 100) }.to raise_error(RuntimeError)
    end
  end

  describe '#clear' do
    it 'invokes order class to clear itself' do
      expect_any_instance_of(Order).to receive(:clear)
      order.clear
    end
  end

  describe '#total' do
    context 'when order is empty' do
      it 'returns 0' do
        expect(order.total).to eq(0)
      end
    end

    context 'when order is not empty' do
      it 'returns a nonzero total' do
        order.add_item('AP1', 'Broward', 100)
        order.add_item('OR1', 'Miami-Dade', 100)

        items = [
          Item.new('AP1', 'Broward', 100, 30.00),
          Item.new('OR1', 'Miami-Dade', 100, 30.00)
        ]
        items.each { |item| order.store.accounting.purchased_price_by_item(item) }

        total = items.inject(0.0) { |sum, item| sum + item.purchased_price }.round(2)

        expect(order.total).to eq(total)
      end
    end
  end

  describe '#profit' do
    context 'when order is empty' do
      it 'returns 0' do
        expect(order.profit).to eq(0)
      end
    end

    context 'when order is not empty' do
      it 'returns a nonzero profit' do
        order.add_item('AP1', 'Broward', 100)
        order.add_item('OR1', 'Miami-Dade', 100)

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

        expect(order.profit).to eq(profit)
      end
    end
  end

  describe '#valid_code? (private)' do
    it 'verifies if code is a valid code' do
      expect(order.send(:valid_code?, 'AP1')).to be_truthy
    end

    it 'verifies if code is not a valid code' do
      expect(order.send(:valid_code?, 'UU1')).to be_falsy
    end
  end
end
