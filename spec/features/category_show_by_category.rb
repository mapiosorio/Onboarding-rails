require 'rails_helper'

RSpec.describe 'show products by category', type: :feature do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:category2) { create(:category) }
  let!(:products2) { create_list(:product, 4, category: category2) }
  let!(:products) { create_list(:product, 10, category: category) }

  context "with a specific category" do
    it "shows the products associated with the category and not products from other categories" do
      login_as(user)
      visit category_path(category)

      products.each do |p|
        expect(page).to have_content(p.name)
      end

      products2.each do |p2|
        expect(page).not_to have_content(p2.name)
      end
    end
  end
end

