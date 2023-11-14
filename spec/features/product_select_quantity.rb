require 'rails_helper'
require 'devise'

RSpec.describe 'select quantity of products', type: :feature do
  let!(:user) { create(:user) }
  let!(:product) { create(:product) }

  context 'with a specific product' do
    it 'lets the user select the quantity' do
      sign_in user
      visit product_path(product)

      expect(page).to have_content('0')
      click_button '+'
      click_button '+'

      expect(page).to have_content('2')
      total = 2 * product.price
      expect(page).to have_content(total)
      click_button '-'

      expect(page).to have_content('1')
      total = 1 * product.price
      expect(page).to have_content(total)
    end
  end
end
