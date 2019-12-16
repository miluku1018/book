require 'rails_helper'



# 可以把商品丟到到購物車裡，然後購物車裡就有東西了。
# 如果加了相同種類的商品到購物車裡，購買項目（CartItem）並不會增加，但商品的數量會改變。
# 商品可以放到購物車裡，也可以再拿出來。
# 每個 Cart Item 都可以計算它自己的金額（小計）。
# 可以計算整台購物車的總消費金額。
# 特別活動可搭配折扣（例如聖誕節的時候全面打 9 折，或是滿額滿千送百或滿額免運費）。

RSpec.describe Cart, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}" 
  context "基本功能" do
   it "可以把商品丟到到購物車裡，然後購物車裡就有東西了 "do
    cart = Cart.new #PORO可以把複雜邏輯包在某個地方,讓code變乾淨
    cart.add_item(1)
    expect(cart.empty?).not_to be true
    # expect(cart.emtpy?).to be false
   end
  end
end
