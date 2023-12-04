require 'rails_helper'
require 'devise'

RSpec.describe 'access root path', type: :feature do
  let!(:user) { create(:user) }

  context 'with authenticated user' do
    it 'redirects to root path' do
      sign_in user
      visit root_path

      expect(page).to have_current_path(root_path)
    end
  end

  context 'without authenticated user' do
    it 'redirects to sign in' do
      visit root_path

      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
