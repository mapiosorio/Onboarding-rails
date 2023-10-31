require 'rails_helper'

RSpec.describe 'delete user', type: :feature do
  let!(:admin_user) { create(:admin_user) }
  let!(:user) { create(:user) }

  before do
    login_as(admin_user)
  end

  it 'deletes the user' do
    visit admin_users_path

      expect(page).to have_content(user.email)
      click_link('Eliminar')

      accept_alert

      expect(page).to have_no_content(user.email)
      expect(User.count).to eq(0)
  end
end
