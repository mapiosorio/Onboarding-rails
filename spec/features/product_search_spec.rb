require 'rails_helper'
require 'devise'

RSpec.describe 'search by product name', type: :feature do
  let!(:category) { create(:category) }
  let!(:user) { create(:user) }
  let!(:product1) { create(:product, category: category) }
  let!(:product2) { create(:product, category: category) }
  let!(:product3) { create(:product) }

  before do
    sign_in user
  end

  scenario 'User searches for products within a category' do
    visit category_path(category)

    fill_in 'search', with: product1.name
    find('.btn.btn-custom-light-blue').click

    expect(page).to have_content(product1.name)
    expect(page).not_to have_content(product2.name)
  end

  scenario 'User searches for products within all products' do
    visit root_path

    fill_in 'search', with: product1.name
    find('.btn.btn-custom-light-blue').click

    expect(page).to have_content(product1.name)
    expect(page).not_to have_content(product2.name)
    expect(page).not_to have_content(product3.name)
  end

  scenario 'User searches for products in a different path' do
    visit product_path(product1)

    fill_in 'search', with: product3.name
    find('.btn.btn-custom-light-blue').click

    expect(page).to have_current_path(root_path(search: product3.name))
    expect(page).to have_content(product3.name)
    expect(page).not_to have_content(product2.name)
    expect(page).not_to have_content(product1.name)
  end

  context 'User clicks the search button with the search bar empty' do
    it 'redirects to root path when in root path' do
      visit root_path(search: product3.name)

      fill_in 'search', with: ''
      find('.btn.btn-custom-light-blue').click

      expect(page).to have_current_path(root_path)
      expect(page).to have_content(product3.name)
      expect(page).to have_content(product2.name)
      expect(page).to have_content(product1.name)
    end

    it 'redirects to root path when not in root path' do
      visit product_path(product1)

      find('.btn.btn-custom-light-blue').click

      expect(page).to have_current_path(root_path)
    end

    it 'does nothing when in ctageory path' do
      visit category_path(category)

      find('.btn.btn-custom-light-blue').click

      expect(page).to have_current_path(category_path(category))
      expect(page).to have_content(product1.name)
      expect(page).to have_content(product2.name)
      expect(page).not_to have_content(product3.name)

    end
  end
end

