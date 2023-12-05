class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @search_query = params[:search]
    @products = @search_query.present? ? Product.where('name ILIKE ?', "%#{@search_query}%") : Product.all
    @pagy, @products = pagy(@products)
  end

  def show
    @order = Order.new
    @product = Product.find(params[:id])
    @additionals = @product.additionals
  end

  def search
    @search_query = params[:search]

    respond_to do |format|
      if request.format.turbo_stream?
        return if @search_query.blank?

        category_id = params[:category_id]
        @category = Category.find_by(id: category_id)
        @products = @category.products.where('name ILIKE ?', "%#{@search_query}%")
        @pagy, @products = pagy(@products)

        format.turbo_stream { render turbo_stream: turbo_stream.replace('products', partial: 'products', locals: { products: @products, pagy: @pagy }) }
      else
        if @search_query.blank?
          format.html { redirect_to root_path }
        else
          format.html { redirect_to root_path(search: @search_query) }
        end
      end
    end
  end
end
