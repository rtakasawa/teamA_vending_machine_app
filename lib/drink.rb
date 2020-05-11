class Drink
  attr_accessor :name,:price,:stock
  def initialize(name,price,stock=1)
    @name = name
    @price = price
    @stock = stock
  end
end