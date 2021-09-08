require_relative '../lib/accounting'
require_relative '../lib/county'

describe Accounting do
  before :each do
    @counties = [
      County.new(name: 'Broward', tax: 7, markup_price: 30),
      County.new(name: 'Miami-Dade', tax: 6, markup_price: 25),
      County.new(name: 'Palm Beach', tax: 8, markup_price: 30)
    ]
  end

  subject(:accounting) { Accounting.new(@counties) }

  describe '#find_by_name' do
    it 'find county by name in counties' do
      expect(accounting.find_by_name('Palm Beach').to_a).to match_array(accounting.counties.last.to_a)
    end

    it 'does not find county' do
      expect(accounting.find_by_name('TBD').to_a).to be_empty
    end
  end

  describe '#counties_count' do
    it 'returns correct counties count' do
      expect(accounting.counties_count).to eq(@counties.count)
    end
  end

  describe '#counties' do
    it 'returns all counties' do
      expect(accounting.counties.count).to eq(@counties.count)
    end
  end

  describe '#counties_names' do
    it 'returns all county names in counties' do
      names = []
      accounting.counties.each { |county| names << county.name }
      expect(accounting.counties_names).to match_array(names)
    end
  end

  describe '#purchased_price_by_item' do
    it 'returns 0 if item quantity is 0' do
      item = Item.new('AP1', 'Broward', 0, 30.00)
      expect(accounting.purchased_price_by_item(item)).to eq(0)
    end
  end

  describe '#to_a' do
    it 'returns counties array' do
      accounting.to_a.each_with_index do |county, index|
        expect(county).to eq(@counties[index].to_a)
      end
    end
  end
end
