require_relative '../lib/product'

describe Product do
  subject(:product) { Product.new('AP1', 'Salix', 'Apple', 30.00, 100) }

  describe '#code' do
    it 'returns product code' do
      expect(product.code).to eq('AP1')
    end
  end

  describe '#brand_name' do
    it 'returns product brand_name' do
      expect(product.brand_name).to eq('Salix')
    end
  end

  describe '#name' do
    it 'returns product name' do
      expect(product.name).to eq('Apple')
    end
  end

  describe '#cost_price' do
    it 'returns cost_price' do
      expect(product.cost_price).to eq(30.00)
    end
  end

  describe '#quantity' do
    it 'returns quantity' do
      expect(product.quantity).to eq(100)
    end
  end

  describe '#to_a' do
    it 'returns product array' do
      expect(product.to_a).to eq([product.code, product.brand_name, product.name, product.cost_price, product.quantity])
    end
  end
end
