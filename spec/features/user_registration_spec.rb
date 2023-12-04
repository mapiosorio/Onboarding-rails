require 'rails_helper'

RSpec.feature 'user registration', type: :feature do
  let(:new_user_attributes) { attributes_for(:user) }
  let!(:user) { create(:user) }

  context 'with valid credentials' do
    it 'redirects registered user to the main page' do
      visit new_user_registration_path

      fill_in 'Nombre', with: new_user_attributes[:name]
      fill_in 'Apellido', with: new_user_attributes[:surname]
      fill_in 'Email', with: new_user_attributes[:email]
      fill_in 'Contraseña', with: new_user_attributes[:password]
      fill_in 'Nombre de su empresa', with: new_user_attributes[:company]
      fill_in 'Cargo en la empresa', with: new_user_attributes[:position]
      click_button 'REGISTRARSE'

      expect(page).to have_current_path(root_path)
    end
  end

  context 'with all fields blank' do
    it 'show registration errors' do
      visit new_user_registration_path

      fill_in 'Nombre', with: ''
      fill_in 'Apellido', with: ''
      fill_in 'Email', with: ''
      fill_in 'Contraseña', with: ''
      fill_in 'Nombre de su empresa', with: ''
      click_button 'REGISTRARSE'

      expect(page).to have_content('Nombre no puede estar en blanco')
      expect(page).to have_content('Apellido no puede estar en blanco')
      expect(page).to have_content('Empresa no puede estar en blanco')
      expect(page).to have_content('Email no puede estar en blanco')
      expect(page).to have_content('Contraseña no puede estar en blanco')
    end
  end

  context 'short password' do
    it 'show registration error' do
      visit new_user_registration_path

      fill_in 'Nombre', with: new_user_attributes[:name]
      fill_in 'Apellido', with: new_user_attributes[:surname]
      fill_in 'Email', with: new_user_attributes[:email]
      fill_in 'Contraseña', with: 'short'
      fill_in 'Nombre de su empresa', with: new_user_attributes[:company]
      click_button 'REGISTRARSE'

      expect(page).to have_content('Contraseña es demasiada corta')
    end
  end

  context 'invalid email' do
    it 'show registration error' do
      visit new_user_registration_path

      fill_in 'Nombre', with: new_user_attributes[:name]
      fill_in 'Apellido', with: new_user_attributes[:surname]
      fill_in 'Email', with: user.email
      fill_in 'Contraseña', with: new_user_attributes[:password]
      fill_in 'Nombre de su empresa', with: new_user_attributes[:company]
      click_button 'REGISTRARSE'

      expect(page).to have_content('Email ya está en uso')
    end
  end
end
