class HomeController < ApplicationController
  before_action :authenticate_user!

  def gifts
    @user = current_user
    @products = Product.all
  end

  def catering
    @user = current_user
  end

  def merchandising
    @user = current_user
  end

  def events
    @user = current_user
  end
end

private
def gift_params
  params.require(:user).permit(:photo)
end
