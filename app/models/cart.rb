class Cart #繼承自object
   def initialize
      @items = []
   end

   def add_item(product_id)
      @items << product_id
   end

   def empty?
      @items.empty?
   end
    
end