class CategoriesController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
  end

  def show
    @user = current_user
    @category = Category.find(params[:id])
    @products = @category.products

    @pagy, @products = pagy(@products)
  end

  def order
    @user = current_user
    @category = Category.find(params[:id])
    sort_option = params[:sort]

    case sort_option
    when 'price_asc'
      @products = @category.products.order(price: :asc)
    when 'price_desc'
      @products = @category.products.order(price: :desc)
    else
      @products = @category.products
    end

    @pagy, @products = pagy(@products)
  end


  def filter
    @user = current_user
    @category = Category.find(params[:id])
    sort_option = params[:sort]
    @products = @category.products

    @pagy, @products = pagy(@products)

  end
end
