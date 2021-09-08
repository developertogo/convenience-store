require_relative '../lib/inventory'
require_relative '../lib/product'

describe Inventory do
  products = [
    Product.new('AP1', 'Salix', 'Apple', 30.00, 100),
    Product.new('OR1', 'Sunkist', 'Orange', 30.00, 100),
    Product.new('PI0', 'Dole', 'Pineapple', 30.00, 100)
  ]
  subject(:inventory) { Inventory.new(products) }

  describe '#find' do
    it 'find product by code in inventory' do
      expect(inventory.find('PI0').to_a).to match_array(inventory.products.last.to_a)
    end

    it 'does not find product not in inventory' do
      expect(inventory.find('TBD').to_a).to be_empty
    end
  end

  describe '#products_count' do
    it 'returns correct products count in inventory' do
      expect(inventory.products_count).to eq(3)
    end
  end

  describe '#products' do
    it 'returns all products in inventory' do
      expect(inventory.products.count).to eq(3)
    end
  end

  describe '#valid_codes' do
    it 'returns valid codes in inventory' do
      codes = []
      inventory.products.each { |product| codes << product.code }
      expect(inventory.valid_codes).to match_array(codes)
    end
  end

  describe '#to_a' do
    it 'returns inventory array' do
      inventory.to_a.each_with_index do |product, index|
        expect(product).to eq(products[index].to_a)
      end
    end
  end
end
