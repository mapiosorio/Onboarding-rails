class CategoriesController < ApplicationController
  before_action :authenticate_user!

  # def index
  #   @search_query = params[:search]
  #   @products = @search_query.present? ? Product.where('name ILIKE ?', "%#{@search_query}%") : Product.all
  #   @pagy, @products = pagy(@products)
  # end

  def show
    @category = Category.find(params[:id])
    @products = @category.products
    @pagy, @products = pagy(@products)
  end

  def filter_order
    @category = Category.find(params[:id])
    @products = @category.products
    apply_filters
    apply_sorting
    @pagy, @products = pagy(@products)
    render 'show'
  end

  private

  def apply_filters
    @filter_params = params.permit(:sharing, :vegan, :sugar_free, :gluten_free, :finger_food)
    @filter_params.each do |param, value|
      @products = @products.where(param) if value == 'true'
    end
  end

  def apply_sorting
    sort_option = params[:sort]
    return unless sort_option

    @products = @products.order(price: sort_option.to_sym)
  end
end
