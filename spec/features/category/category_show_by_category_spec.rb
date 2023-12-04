require 'rails_helper'
require 'devise'

RSpec.describe 'show products by category', type: :feature do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:category2) { create(:category) }
  let!(:products) { create_list(:product, 10, category: category) }
  let!(:product2) { create(:product, category: category2, name: 'prueba') }

  context 'with a specific category' do
    it 'shows the products associated with the category and not products from other categories' do
      sign_in user
      visit category_path(category)

      products.each do |product|
        expect(page).to have_content(product.name)
      end

      expect(page).not_to have_content(product2.name)
    end
  end
end
