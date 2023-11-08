require 'rails_helper'

RSpec.describe 'filter products', type: :feature do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:vegan_sharing_products) { create_list(:product, 5, category: category, sharing: true, vegan: true) }
  let(:products) { create_list(:product, 5, category: category, sharing: false, vegan: false) }

  context 'with a filter' do
    it 'shows the products with the filter' do
      login_as(user)
      vegan_sharing_products = category.products
      visit filter_order_category_path(category, sharing: 'true')

      vegan_sharing_products.each do |product|
        expect(page).to have_content(product.name)
      end

      products.each do |product|
        expect(page).not_to have_content(product.name)
      end
    end
  end

  context 'with more than one filter' do
    it 'shows products that match the filters' do
      login_as(user)
      vegan_sharing_products = category.products
      visit filter_order_category_path(category, sharing: 'true', vegan: 'true')

      vegan_sharing_products.each do |product|
        expect(page).to have_content(product.name)
      end

      products.each do |product|
        expect(page).not_to have_content(product.name)
      end
    end
  end
end
