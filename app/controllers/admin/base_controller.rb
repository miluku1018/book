class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :permission_check!

  private
  def permission_check!
    redirect_to root_path, notice: '無法存取' if current_user.role != 'admin'
  end

end