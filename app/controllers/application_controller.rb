class ApplicationController < ActionController::Base
  
  helper_method :current_cart #讓controller & view 同時擁有
  private
  def current_cart
    @cart ||= Cart.from_hash(session[:hippo2000]) #如果使用區域變數，執行完就結束了，表示line 3 &4 都是拿到新的
  end
end
