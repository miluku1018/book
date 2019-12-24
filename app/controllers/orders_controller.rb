class OrdersController < ApplicationController
  before_action :authenticate_user!

  layout 'book'

  def index
    # @orders = Order.whrere(user: current_user)
    @orders = current_user.orders.order(id: :desc) 
  end

  def pay
    @token = gateway.client_token.generate
    @order = current_user.orders.find_by(num: params[:id])
  end

  def paid
    nonce = params[:nonce]
    order = current_user.orders.find_by(num: params[:id])
    # redirect_to oroders_path, notice: '交易完成'
    
    result = gateway.transaction.sale(
      :amount => order.total_price,
      :payment_method_nonce => nonce,
      :options => {
        :submit_for_settlement => true
      }
    )

    if result.success?
      order.pay!(transaction_id: result.transaction.id)
      # pay!有update功能，因此將產生交易id,與付款同時產生,就不用跑兩次update

      redirect_to orders_path, notice: '交易完成'
    else
      redirect_to orders_path, notice: "交易發生錯誤! #{result.transaction.status}"
    end
  end

  def cancel
   order = current_user.orders.find_by(num: params[:id]) #限定自己的訂單才能刪除,避免修改網頁路徑,可以刪除別人的訂單
  
   if order.paid?
    gateway.transaction.void(order.transaction_id)
    result = gateway.transaction.refund(order.transaction_id)

    if result.success?
      order.cancel! if order.may_cancel?
  #rails c 裡面的方法, 表示刪除, ex: o1.may_pay? true/ o1.pay! 同理o1.cancel
      redirect_to orders_path, notice: "訂單#{order.num}已取消並完成退款"
    else
      redirect_to orders_path, notice: "訂單#{order.num}退款發生錯誤"
    end
  else
    order.cancel! if order.may_cancel?
    redirect_to orders_path, notice: "訂單#{order.num}已取消"
  end
  end
  
  def create
    @order = current_user.orders.build(order_params)

    current_cart.items.each do |item|
     @order.order_items.build(book: item.product,
                             quantity: item.quantity,
                             sell_price: item.product.sell_price)
                             #order_item跟在訂單後面,加上售價是為了避免之後的價格有變動
    end
    if @order.save
      #清空購物車
      session[:hippo2000] = nil
      #進入付款
      redirect_to pay_order_path(@order.num), notice: "訂單已成立"
    else
      flash[:notice] = @order.errors.full_messages
      redirect_to root_path    
    end
  end

  private
  def order_params
    params.require(:order).permit(:recipient, :tel, :address, :note)
  end

  def gateway
    Braintree::Gateway.new(
      :environment => :sandbox,
      merchant_id: ENV['braintree_merchant_id'],
      public_key: ENV['braintree_public_key'],
      private_key: ENV['braintree_private_key']
    )
  end
end
