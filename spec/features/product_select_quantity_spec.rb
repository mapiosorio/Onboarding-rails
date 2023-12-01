require 'rails_helper'
require 'devise'
require 'uri'

RSpec.describe 'select quantity of products', type: :feature do
  let!(:user) { create(:user, id: 20) }
  let!(:product) { create(:product, id: 16, price: 10) }

  context 'with a specific product' do
    it 'lets the user select the quantity' do
      sign_in user
      visit product_path(product)

      expect(page).to have_content('1')
      expect(page).to have_content(product.price)
      click_button '+'
      click_button '+'

      total = 3 * product.price
      expect(page).to have_content(total)
      click_button '-'

      total = 2 * product.price
      expect(page).to have_content(total)
      click_button 'COMPRAR'

      expected_relative_url = new_order_path
      actual_url = page.current_url
      actual_relative_path = URI.parse(actual_url).path

      expect(actual_relative_path).to eq(expected_relative_url)
    end
  end
end
