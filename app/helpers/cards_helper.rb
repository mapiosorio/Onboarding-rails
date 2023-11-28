module CardsHelper
  def masked_card_number(card_number)
    card_number = card_number.to_s
    '*' * 12 + card_number[-4, 4]
  end
end
