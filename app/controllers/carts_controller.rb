class CartsController < ApplicationController
  def add
    current_cart.add_item(params[:id])  #ruby 有記憶空間, 第一次拿是空的
    session[:hippo2000] = current_cart.serialize #session＝儲存空間/ 第二次已經有東西, 拿的是@cart

    redirect_to root_path, notice: '成功加入購物車'
  end
end
