require_relative '../lib/store.rb'

describe Store do
  before :each do
    @counties = [
      County.new(name: 'Broward', tax: 7, markup_price: 30),
      County.new(name: 'Miami-Dade', tax: 6, markup_price: 25),
      County.new(name: 'Palm Beach', tax: 8, markup_price: 30)
    ]
    @products = [
      Product.new('AP1', 'Salix', 'Apple', 30.00, 100),
      Product.new('OR1', 'Sunkist', 'Orange', 30.00, 100),
      Product.new('PI0', 'Dole', 'Pineapple', 30.00, 100)
    ]
  end

  subject(:store) do
    Store.new('St. Bernard Corner', @counties, @products)
  end

  describe '#name' do
    it 'returns store name' do
      expect(store.name).to eq('St. Bernard Corner')
    end
  end

  describe '#accounting' do
    it 'returns accounting counties count' do
      expect(store.accounting.counties_count).to eq(@counties.count)
    end
  end

  describe '#inventory' do
    it 'returns inventory product count' do
      expect(store.inventory.products.count).to eq(@products.count)
    end
  end
end
