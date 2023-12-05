class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def show
    @category = Category.find(params[:id])
    @products = @category.products
    @pagy, @products = pagy(@products)
  end

  def filter_order
    @category = Category.find(params[:id])
    @products = @category.products
    apply_sorting
    @pagy, @products = pagy(@products)
    render 'show'
  end

  def filter
    request_data = JSON.parse(request.body.read)
    categoryId = request_data['categoryId']
    filterParams = request_data['filterParams']
    sortValue = request_data['sortValue']

    @category = Category.find(categoryId)
    @products = @category.products

    filterParams.each do |param, value|
      @products = @products.where(param => true) if value
    end

    if sortValue.present?
      @products = @products.order(price: sortValue.to_sym)
    end

    @pagy, @products = pagy(@products)
    render turbo_stream: turbo_stream.replace('products', partial: 'products/products', locals: { products: @products, pagy: @pagy })
  end

  private

  def apply_sorting
    sort_option = params[:sort]
    return unless sort_option

    @products = @products.order(price: sort_option.to_sym)
  end
end
