class ProductsController < ApplicationController
  def show
    @order = Order.new
    @product = Product.find(params[:id])
    @additionals = @product.additionals
  end
end
