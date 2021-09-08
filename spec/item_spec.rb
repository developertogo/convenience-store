require_relative '../lib/item'

describe Item do
  subject(:item) { Item.new('AP1', 'Miami-Dade', 6, 8.00) }

  describe '#code' do
    it 'returns item code' do
      expect(item.code).to eq('AP1')
    end
  end

  describe '#county_name' do
    it 'returns item county_name' do
      expect(item.county_name).to eq('Miami-Dade')
    end
  end

  describe '#quantity' do
    it 'returns item quantity' do
      expect(item.quantity).to eq(6)
    end
  end

  describe '#unit_price' do
    it 'returns item unit_price' do
      expect(item.unit_price).to eq(8.00)
    end
  end

  describe '#purchased_price' do
    it 'returns item purchased_price' do
      item = Item.new('AP1', 'Broward', 100, 30.00)
      expect(item.purchased_price).to eq(-1)
    end
  end

  describe '#to_a' do
    it 'returns an array' do
      expect(item.to_a).to eq([item.code, item.county_name, item.quantity, item.unit_price, item.purchased_price])
    end
  end
end
