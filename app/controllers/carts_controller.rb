class CartsController < ApplicationController
  before_action :authenticate_user!, only: [:checkout]
  layout 'book'

  def add
    current_cart.add_item(params[:id])  #ruby 有記憶空間, 第一次拿是空的
    session[:hippo2000] = current_cart.serialize #session＝儲存空間/ 第二次已經有東西, 拿的是@cart
    render json: {items: current_cart.items.count}
    # redirect_to root_path, notice: '成功加入購物車'
  end

  def show

  end

  def destroy
    session[:hippo2000] = nil
    redirect_to root_path, notice: '購物車已清空'
  end

  def checkout
    @order = Order.new
  end
end
