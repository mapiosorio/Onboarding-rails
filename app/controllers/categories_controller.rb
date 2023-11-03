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

  def filter_order
    @user = current_user
    @category = Category.find(params[:id])
    @products = @category.products
    sort_option = params[:sort]

    @filter_params = params.permit(:sharing, :vegan, :sugar_free, :gluten_free, :finger_food)

    @filter_params.each do |param, value|
      @products = @products.where(param) if value == 'true'
    end

    if sort_option == 'price_asc'
      @products = @products.order(price: :asc)
    elsif sort_option == 'price_desc'
      @products = @products.order(price: :desc)
    else
      @products = @products
    end

    @pagy, @products = pagy(@products)

    render 'show'
  end
end
