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
    category_id = request_data['categoryId']
    filter_params = request_data['filterParams']
    sort_value = request_data['sortValue']

    @category = Category.find(category_id)
    @products = @category.products

    filter_params.each do |param, value|
      @products = @products.where(param => true) if value
    end

    @products = @products.order(price: sort_value.to_sym) if sort_value.present?

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
