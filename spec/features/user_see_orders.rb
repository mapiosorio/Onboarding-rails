require 'rails_helper'
require 'devise'

RSpec.describe 'see orders as user', type: :feature do
  let!(:user) { create(:user) }
  let!(:order) { create(:order, user: user) }
  let!(:order2) { create(:order, user: user) }
  let!(:order_not_associated) { create(:order) }

  before do
    sign_in(user)
    visit orders_path
  end

  it 'displays orders associated with the user' do
    expect(page).to have_content(I18n.t('order.index.count', order_amount: 2))
    expect(page).to have_content(order.total)
    expect(page).to have_content(order.delivery_direction)
    expect(page).to have_content(order2.total)
    expect(page).to have_content(order2.delivery_direction)
    expect(page).not_to have_content(order_not_associated.total)
    expect(page).not_to have_content(order_not_associated.delivery_direction)
  end
end
