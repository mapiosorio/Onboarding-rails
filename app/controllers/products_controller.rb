class ProductsController < ApplicationController
  def show
    @user = current_user
    @product = Product.find(params[:id])
    @additionals = @product.additionals
  end
end
