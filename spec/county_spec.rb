require_relative '../lib/county'

describe County do
  subject(:county) { County.new(name: 'Broward', tax: 7, markup_price: 30) }

  describe '#name' do
    it 'returns county name' do
      expect(county.name).to eq('Broward')
    end
  end

  describe '#tax' do
    it 'returns tax percentage' do
      expect(county.tax).to eq(7)
    end
  end

  describe '#markup_price' do
    it 'returns mark-up price percentage' do
      expect(county.markup_price).to eq(30)
    end
  end

  describe '#to_a' do
    it 'returns county array' do
      expect(county.to_a).to eq([county.name, county.tax, county.markup_price])
    end
  end
end
