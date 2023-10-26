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

    if sort_option == 'price_asc'
      @products = @category.products.order(price: :asc)
    elsif sort_option == 'price_desc'
      @products = @category.products.order(price: :desc)
    else
      @products = @category.products
    end

    @pagy, @products = pagy(@products)

    render 'show'
  end

  def filter
    @user = current_user
    @category = Category.find(params[:id])
    @products = @category.products

    @filter_params = params.permit(:sharing, :vegan, :sugar_free, :gluten_free, :picada)

    @filter_params.each do |param, value|
      @products = @products.where(param) if value == 'true'
    end

    @pagy, @products = pagy(@products)


    render 'show'
  end
end
