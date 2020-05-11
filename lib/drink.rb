class Drink
  attr_reader :name,:price,:stock
  # attr_accessor :name,:price,:stock
  def initialize(name,price,stock=1)
    @name = name
    @price = price
    @stock = stock
  end
end