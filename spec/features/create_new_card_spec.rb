require 'rails_helper'
require 'devise'

RSpec.describe 'create a new card', type: :feature do
  let!(:user) { create(:user) }
  let!(:product) { create(:product) }
  let(:new_card_attributes) { attributes_for(:card) }

  before do
    sign_in user
    @order_params = { order: { product_id: product.id, quantity: 3, user_id: user.id, commit: 'COMPRAR' } }
    visit new_order_path(@order_params)

    find('a', text: 'Añadir una tarjeta').click
  end

  context 'with valid atrributes' do
    it 'creates the card' do
      fill_in 'Número de la tarjeta', with: new_card_attributes[:number]
      fill_in 'Nombre del titular', with: new_card_attributes[:cardholder]
      fill_in 'Fecha de vencimiento', with: new_card_attributes[:expiration_date]
      fill_in 'CVV', with: new_card_attributes[:cvv]
      click_button 'CONFIRMAR'

      full_card_number = new_card_attributes[:number].to_s
      masked_card_number = '************' + full_card_number[-4, 4]
      select masked_card_number, from: 'order_card_id'
    end
  end

  context 'with all fields blank' do
    it 'shows validation errors' do
      click_button 'CONFIRMAR'

      expect(page).to have_content("#{ I18n.t('activerecord.attributes.card.number') } #{ I18n.t('activerecord.errors.messages.blank') }")
      expect(page).to have_content("#{ I18n.t('activerecord.attributes.card.expiration_date') } #{ I18n.t('activerecord.errors.messages.blank') }")
      expect(page).to have_content("#{ I18n.t('activerecord.attributes.card.cardholder') } #{ I18n.t('activerecord.errors.messages.blank') }")
      expect(page).to have_content("#{ I18n.t('activerecord.attributes.card.cvv') } #{ I18n.t('activerecord.errors.messages.blank') }")
      expect(page).to have_content("#{ I18n.t('activerecord.attributes.card.cvv') } #{ I18n.t('activerecord.errors.messages.wrong_length') }")
      expect(page).to have_content("#{ I18n.t('activerecord.attributes.card.number') } #{ I18n.t('activerecord.errors.messages.wrong_length') }")
    end
  end
end
