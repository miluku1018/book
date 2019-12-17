require 'rails_helper'

# 可以把商品丟到到購物車裡，然後購物車裡就有東西了。
# 如果加了相同種類的商品到購物車裡，購買項目（CartItem）並不會增加，但商品的數量會改變。
# 商品可以放到購物車裡，也可以再拿出來。
# 每個 Cart Item 都可以計算它自己的金額（小計）。
# 可以計算整台購物車的總消費金額。
# 特別活動可搭配折扣（例如聖誕節的時候全面打 9 折，或是滿額滿千送百或滿額免運費）。
# pending "add some examples to (or delete) #{__FILE__}"
RSpec.describe Cart, type: :model do

  context "進階功能" do
    it "可以將購物車內容轉換成 Hash 並存到 Session 裡" do
      cart = Cart.new

      book1 = create(:book)
      book2 = create(:book)

      3.times { cart.add_item(book1.id) }
      2.times { cart.add_item(book2.id) }

      # cart_hash = {
      #   "items" => [
      #     {"product_id" => 1, "quantity" => 3}, 
      #     {"product_id" => 2, "quantity" => 2}
      #   ]
      # }

      expect(cart.serialize).to eq cart_hash
    end

    it "存放在session的內容（Hash),還原成購物車的內容" do
      # cart_hash = {
      #   "items" => [
      #     {"product_id"=> 1, "quantity" => 3},
      #     {"product_id"=> 2, "quantity" => 2}
      #   ]
      # }
      cart = Cart.from_hash(cart_hash)

      expect(cart.items.count).to be 2
      expect(cart.items.first.quantity).to be 3
    end
  end
  context "基本功能" do
    it "可以把商品丟到到購物車裡，然後購物車裡就有東西了 "do
      cart = Cart.new #PORO可以把複雜邏輯包在某個地方,讓code變乾淨
      cart.add_item(1)
      # expect(cart.empty?).not_to be true
      expect(cart).not_to be_empty
      # expect(cart.emtpy?).to(be(false))
    end

    it "如果加了相同種類的商品到購物車裡，購買項目（CartItem）並不會增加，但商品的數量會改變" do
      cart = Cart.new
      3.times{cart.add_item(1)}
      2.times{cart.add_item(2)}
      expect(cart.items.count).to be 2 #count自己掰的
      expect(cart.items.first.quantity).to be 3 
    end

    it "商品可以放到購物車裡，也可以再拿出來。" do
     cart = Cart.new
    #  p1 = FactoryBot.create(:publisher)
    #  c1 = FactoryBot.create(:category)
    #  b1 = FactoryBot.create(:book)
     book = create(:book)

     cart.add_item(book.id)
     expect(cart.items.first.product).to be_a Book
     #db/test.sqlite3 不會寫入真正的資料庫
    end

    it "可以計算整台購物車的總消費金額" do
      cart = Cart.new
      #Arrange
      book1 = create(:book, sell_price: 50)
      book2 = create(:book, sell_price: 100)
      
      #Act
      3.times{cart.add_item(book1.id)}
      2.times{cart.add_item(book2.id)}
      
      #Assert
      expect(cart.total_price).to eq 350
    end
  end

  private
  def cart_hash
   {
      "items" => [
        {"product_id" => 1, "quantity" => 3},
        {"product_id" => 2, "quantity" => 2}
      ]
    }
  end
end
 