require 'rails_helper'
require 'devise'

RSpec.describe 'create a new order', type: :feature do
  let!(:user) { create(:user) }
  let!(:product) { create(:product) }
  let(:new_order_attributes) { attributes_for(:order) }
  let!(:card) { create(:card, user: user) }

  context 'with big sreen size' do
    it 'creates the order' do
      sign_in user
      order_params = { order: { product_id: product.id, quantity: 3, user_id: user.id, commit: 'COMPRAR' } }
      visit new_order_path(order_params)

      fill_in 'Nombre y apellido', with: new_order_attributes[:recipient_name]
      fill_in 'Fecha de entrega', with: new_order_attributes[:delivery_date]
      fill_in 'Dirección de entrega', with: new_order_attributes[:delivery_direction]
      fill_in 'Número de contacto', with: new_order_attributes[:recipient_phone_number]
      fill_in 'Horario de entrega', with: new_order_attributes[:delivery_time]
      fill_in 'RUT', with: new_order_attributes[:rut]
      fill_in 'Razón Social', with: new_order_attributes[:company_name]

      full_card_number = card.number.to_s
      masked_card_number = '************' + full_card_number[-4..-1]
      select masked_card_number, from: 'order_card_id'
      click_button 'COMPRAR'

      expect(page).to have_current_path(root_path)
    end

    context 'with all fields blank' do
      it 'shows validation errors' do
        sign_in user
        order_params = { order: { product_id: product.id, quantity: 3, user_id: user.id, commit: 'COMPRAR' } }
        visit new_order_path(order_params)

        click_button 'COMPRAR'

        expect(page).to have_content('Tarjeta es un campo requerido')
        expect(page).to have_content('Nombre y apellido no puede estar en blanco')
        expect(page).to have_content('La fecha de entrega no puede estar en blanco')
        expect(page).to have_content('El horario de entrega no puede estar en blanco')
        expect(page).to have_content('El Número de contacto no puede estar en blanco')
        expect(page).to have_content('El RUT no puede estar en blanco')
        expect(page).to have_content('La Razón Social no puede estar en blanco')
        expect(page).to have_content('la Dirección de entrega no puede estar en blanco')
      end
    end
  end

  context 'with small screen size' do
    it 'creates the order' do
      page.driver.browser.manage.window.resize_to(320, 480)
      sign_in user
      order_params = { order: { product_id: product.id, quantity: 3, user_id: user.id, commit: 'COMPRAR' } }
      visit new_order_path(order_params)

      fill_in 'Nombre y apellido', with: new_order_attributes[:recipient_name]
      fill_in 'Fecha de entrega', with: new_order_attributes[:delivery_date]
      fill_in 'Dirección de entrega', with: new_order_attributes[:delivery_direction]
      fill_in 'Número de contacto', with: new_order_attributes[:recipient_phone_number]
      fill_in 'Horario de entrega', with: new_order_attributes[:delivery_time]

      click_button 'VALIDAR COMPRA'

      fill_in 'RUT', with: new_order_attributes[:rut]
      fill_in 'Razón Social', with: new_order_attributes[:company_name]

      full_card_number = card.number.to_s
      masked_card_number = '************' + full_card_number[-4..-1]
      select masked_card_number, from: 'order_card_id'
      click_button 'COMPRAR'

      expect(page).to have_current_path(root_path)
    end

    context 'with all fields blank' do
      it 'shows validation errors in new_order_path' do
        page.driver.browser.manage.window.resize_to(320, 480)
        sign_in user
        order_params = { order: { product_id: product.id, quantity: 3, user_id: user.id, commit: 'COMPRAR' } }
        visit new_order_path(order_params)

        click_button 'VALIDAR COMPRA'

        expect(page).to have_content('La fecha de entrega no puede estar en blanco')
        expect(page).to have_content('El horario de entrega no puede estar en blanco')
        expect(page).to have_content('El Número de contacto no puede estar en blanco')
        expect(page).to have_content('la Dirección de entrega no puede estar en blanco')
        expect(page).to have_content('Nombre y apellido no puede estar en blanco')
      end

      it 'shows validation errors in additional_information_new_order_path' do
        page.driver.browser.manage.window.resize_to(320, 480)
        sign_in user
        order_params = {
          order: {
            product_id: product.id,
            quantity: 3,
            user_id: user.id,
            commit: 'COMPRAR',
            recipient_name: 'John Doe',
            delivery_date: '2023-12-20',
            delivery_direction: '123 Main St',
            recipient_phone_number: '123-456-7890',
            delivery_time: '10:00 AM'
          }
        }
        visit additional_information_new_order_path(order_params)

        click_button 'COMPRAR'

        expect(page).to have_content('Tarjeta es un campo requerido')
        expect(page).to have_content('El RUT no puede estar en blanco')
        expect(page).to have_content('La Razón Social no puede estar en blanco')
      end
    end
  end
end
