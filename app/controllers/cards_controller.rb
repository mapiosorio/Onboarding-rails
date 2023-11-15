class CardsController < ApplicationController
  def create
    @card = Card.new(card_params)

    respond_to do |format|
      if @card.save
        format.turbo_stream
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('new_card', partial: 'new_card_form', locals: { card: @card })
        end
      end
    end
  end

  private

  def card_params
    params.require(:card).permit(:number, :cvv, :cardholder, :expiration_date, :user_id)
  end
end
