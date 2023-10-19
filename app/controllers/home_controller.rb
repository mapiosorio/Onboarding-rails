class HomeController < ApplicationController
  before_action :authenticate_user!

  def gifts
    @user = current_user
    @products = Product.all
    @suppliers = Supplier.all
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
