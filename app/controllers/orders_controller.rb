class OrdersController < ApplicationController

  def new
    @order = Order.new(order_params)
    @product = Product.find(@order.product_id)
    if @order.quantity > 0
      @additionals = Additional.where(id: @order.additional_ids)
      calculate_cost
    elsif !@order.valid?
      @additionals = @product.additionals
      render 'products/show'
    end
  end

  def additional_information
    @order = Order.new(order_params)
    @product = Product.find(@order.product_id)
    @additionals = Additional.where(id: @order.additional_ids)
    if !@order.recipient_name.blank? && !@order.recipient_phone_number.blank? && !@order.delivery_date.blank? && !@order.delivery_time.blank? && !@order.delivery_direction.blank?
      calculate_cost
    elsif !@order.valid?
      render :new
    end
  end

  def create
    @order = Order.new(order_params)
    @additionals = Additional.where(id: @order.additional_ids)
    if @order.save
      redirect_to root_path
    else
      @product = Product.find(@order.product_id)
      referer_path = URI.parse(request.referer).path
      if referer_path == additional_information_new_order_path
        render :additional_information, status: :unprocessable_entity
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :product_id, :quantity, :total, :subtotal, :taxes, :surprise_delivery, :delivery_time, :delivery_date, :recipient_name, :recipient_phone_number, :personalization, :delivery_direction, :personalization_message, :re_delivery, :rut, :company_logo, :company_name, additional_ids: [])
  end

  def calculate_cost
    additionals_cost = 0
    if @additionals.present?
      additionals_cost = @additionals.sum(&:price)
    end
    @order.subtotal = @order.quantity * (@product.price + additionals_cost)
    @order.taxes = @order.subtotal * 0.22
    @order.total = @order.taxes + @order.subtotal + @product.provider.delivery_cost
  end
end
