class OrdersController < ApplicationController
  def new
    @order = Order.new(order_params)
    @product = Product.find(@order.product_id)
    @cards = current_user.cards
    @card = Card.new
    @additionals = Additional.where(id: @order.additional_ids)
    calculate_cost
  end

  def additional_information
    @order = Order.new(order_params)
    @product = Product.find(@order.product_id)
    @additionals = Additional.where(id: @order.additional_ids)
    @cards = current_user.cards
    @card = Card.new
    if all_required_fields_present?(@order)
      calculate_cost
    elsif @order.invalid?
      render :new
    end
  end

  def create
    @order = Order.new(order_params)
    @additionals = Additional.where(id: @order.additional_ids)

    if @order.save
      redirect_to root_path
    else
      @card = Card.new
      @cards = current_user.cards
      @product = Product.find(@order.product_id)
      referer_path = URI.parse(request.referer).path
      view = referer_path == additional_information_new_order_path ? :additional_information : :new
      render view, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :product_id, :card_id, :quantity, :total, :subtotal, :taxes,
                                  :surprise_delivery, :delivery_time, :delivery_date, :recipient_name, :recipient_phone_number, :personalization, :delivery_direction, :personalization_message, :re_delivery, :rut, :company_logo, :company_name, additional_ids: [])
  end

  def calculate_cost
    additionals_cost = 0
    additionals_cost = @additionals.sum(&:price) if @additionals.present?
    @order.subtotal = @order.quantity * (@product.price + additionals_cost)
    @order.taxes = @order.subtotal * 0.22
    @order.total = @order.taxes + @order.subtotal + @product.provider.delivery_cost
  end

  def all_required_fields_present?(order)
    order.recipient_name.present? &&
    order.recipient_phone_number.present? &&
    order.delivery_date.present? &&
    order.delivery_time.present? &&
    order.delivery_direction.present?
  end
end
