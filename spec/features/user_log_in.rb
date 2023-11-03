require 'rails_helper'

RSpec.feature 'user login', type: :feature do
  let!(:user) { create(:user) }

  context 'with valid credentials' do
    it 'redirects logged in user to main page' do
      visit new_user_session_path

      fill_in 'Email', with: user.email
      fill_in 'Contraseña', with: user.password
      click_button 'INICIAR SESIÓN'

      expect(page).to have_current_path(root_path)
    end
  end

  context 'with invalid credentials' do
    it 'show login error' do
      visit new_user_session_path

      fill_in 'Email', with: 'invalid@example.com'
      fill_in 'Contraseña', with: 'wrongpassword'
      click_button 'INICIAR SESIÓN'

      expect(page).to have_content('Email o contraseña inválidos.')
    end

    it 'show login error' do
      visit new_user_session_path

      fill_in 'Email', with: user.email
      fill_in 'Contraseña', with: 'wrongpassword'
      click_button 'INICIAR SESIÓN'

      expect(page).to have_content('Email y/o contraseña inválidos.')
    end

    it 'show login error' do
      visit new_user_session_path

      fill_in 'Email', with: 'invalid@example.com'
      fill_in 'Contraseña', with: user.password
      click_button 'INICIAR SESIÓN'

      expect(page).to have_content('Email o contraseña inválidos.')
    end
  end
end
