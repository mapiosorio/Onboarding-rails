class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    @additionals = @product.additionals
  end
end
