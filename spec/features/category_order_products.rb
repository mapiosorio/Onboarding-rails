require 'rails_helper'

RSpec.describe 'order products', type: :feature do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:products) { create_list(:product, 10, category: category) }

  context 'with a specific category' do
    it 'shows the products associated with the category ordered by price in ascending order' do
      login_as(user)
      sorted_products_asc = category.products.order(price: :asc)
      visit filter_order_category_path(category, sort: 'price_asc')

      expect(products).to match_array(sorted_products_asc)
    end

    it 'shows the products associated with the category ordered by price in descending order' do
      login_as(user)
      sorted_products_desc = category.products.order(price: :desc)
      visit filter_order_category_path(category, sort: 'price_desc')

      expect(products).to match_array(sorted_products_desc)
    end
  end
end

