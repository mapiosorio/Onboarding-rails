require 'rails_helper'

RSpec.describe 'filter products', type: :feature do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:filter_products) { create_list(:product, 5, category: category, sharing: true, vegan: true) }
  let(:none_filter_products) { create_list(:product, 5, category: category, sharing: false, vegan: false) }

  context "with a filter" do
    it "shows the products with the filter" do
      login_as(user)
      filter_products = category.products
      visit filter_path(category, sharing: 'true')

      filter_products.each do |product|
        expect(page).to have_content(product.name)
      end

      none_filter_products.each do |product|
        expect(page).not_to have_content(product.name)
      end
    end
  end

  context "with more than one filter" do
    it "shows the products with those filters" do
      login_as(user)
      filter_products = category.products
      visit filter_path(category, sharing: 'true', vegan: 'true')

      filter_products.each do |product|
        expect(page).to have_content(product.name)
      end

      none_filter_products.each do |product|
        expect(page).not_to have_content(product.name)
      end
    end
  end
end
