class CardsController < ApplicationController
  def create
    @card = Card.new(card_params)
    return if @card.save

    render turbo_stream: turbo_stream.replace('new_card', partial: 'form', locals: { card: @card })
  end

  private

  def card_params
    params.require(:card).permit(:number, :cvv, :cardholder, :expiration_date, :user_id)
  end
end
