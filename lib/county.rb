class County
  attr_reader :name, :tax, :markup_price

  def initialize(name:, tax:, markup_price:)
    @name = name
    @tax = tax
    @markup_price = markup_price
  end

  def to_a
    [@name, @tax, @markup_price]
  end

  def to_s
    "#{@name}, #{@tax}, #{@markup_price}"
  end
end
