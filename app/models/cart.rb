class Cart #繼承自object
   attr_reader :items
   def initialize(items = []) #塞入預設值, 為了讓63行能使用
    @items = items
   end

   def add_item(product_id)
    found_item = @items.find{|item| item.product_id == product_id}
    #ruby array本來就有find方法
    #＠items is an array
    #found_item是一種item

    if found_item
      found_item.increment!    
    else
      @items << CartItem.new(product_id)
    end
    #item = CartItem, 有包含product_id
   end

   def empty?
    @items.empty?
   end

   def total_price
      @items.reduce(0) {|sum, item| sum + item.total_price}
   #   total = 0
   #   @items.each do |item|
   #     total = total + item(CartItem).total_price
   #   end
   #   return total
   end

   def serialize
      result = @items.map { |item|
        {"product_id" => item.product_id, "quantity" => item.quantity}
      }
      # result = []
      # @items.each do |item|
      #   result << {"product_id" => item.product_id, "qunatity" => item.quantity}
      # end
      # items => [
      #   {"product_id"=> 1, "quantity" => 3},
      #   {"product_id"=> 2, "quantity" => 2}
      # ]
      {"items" => result}
   end

   def self.from_hash(hash = nil) #類別方法
      # cart_hash = {
      #    "items" => [
      #      {"product_id"=> 1, "quantity" => 3},
      #      {"product_id"=> 2, "quantity" => 2}
      #    ]
      #  }
      if hash && hash["items"]
        #還原
        items = []
        hash["items"].each do |item|
         items << CartItem.new(item["product_id"], item["quantity"])
        end
        Cart.new(items)
      else
        #新車
        Cart.new([])
      end
   end
end
   # def items
   #  return @items
   # end