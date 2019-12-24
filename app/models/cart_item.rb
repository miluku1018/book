class CartItem
  attr_reader :product_id, :quantity #先開reader,如果有需要再開writer

  def initialize(product_id, quantity = 1)
    @product_id = product_id
    @quantity = quantity
  end

  def increment!
    @quantity += 1
  end

  def product
    Book.find_by(id: product_id)
  end

  def total_price
    @quantity * product.sell_price.to_i
  end
end