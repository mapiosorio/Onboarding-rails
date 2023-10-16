require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:surname) }
    it { is_expected.to validate_presence_of(:company) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end
end

RSpec.feature 'user registration', type: :feature do
  let(:new_user_attributes) { attributes_for(:user) }
  let!(:user) { create(:user) }

  context 'with valid credentials' do
    it 'redirects registered user to the main page' do
      visit new_user_registration_path
      fill_in 'Nombre', with: new_user_attributes[:name]
      fill_in 'Apellido', with: new_user_attributes[:surname]
      fill_in 'Email', with: new_user_attributes[:email]
      fill_in 'Contraseña' , with: new_user_attributes[:password]
      fill_in 'Nombre de su empresa', with: new_user_attributes[:company]
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
      fill_in 'Contraseña' , with: ''
      fill_in 'Nombre de su empresa', with: ''
      click_button 'REGISTRARSE'
      # binding.pry
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
      fill_in 'Contraseña' , with: 'short'
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
      fill_in 'Contraseña' , with: new_user_attributes[:password]
      fill_in 'Nombre de su empresa', with: new_user_attributes[:company]
      click_button 'REGISTRARSE'
      expect(page).to have_content('Email ya está en uso')
    end
  end
end


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

RSpec.feature 'reset password' do
  let!(:user) { create(:user) }
  let(:new_user_attributes) { attributes_for(:user) }

  context 'with valid email' do
    scenario 'success' do
      visit new_user_password_path
      fill_in 'Email', with: user.email
      click_button 'CAMBIAR CONTRASEÑA'
      sleep(2)
      expect(ActionMailer::Base.deliveries.count).to eq(1)

      email = ActionMailer::Base.deliveries.last

      reset_token = email.body.to_s.match(/token=(\w+)/)[1]

      visit "/users/password/edit?reset_password_token=#{reset_token}"

      fill_in 'Nueva contraseña', with: new_user_attributes[:password]
      fill_in 'Confirma la nueva contraseña', with: new_user_attributes[:password]
      click_button 'Cambiar mi contraseña'
      expect(page).to have_current_path(root_path)
      expect(ActionMailer::Base.deliveries.count).to eq(2)
    end

    scenario 'invalid token' do
      visit new_user_password_path
      fill_in 'Email', with: user.email
      click_button 'CAMBIAR CONTRASEÑA'
      sleep(2)
      expect(ActionMailer::Base.deliveries.count).to eq(1)

      email = ActionMailer::Base.deliveries.last
      reset_token = 'invalid'
      visit "/users/password/edit?reset_password_token=#{reset_token}"
      fill_in 'Nueva contraseña', with: new_user_attributes[:password]
      fill_in 'Confirma la nueva contraseña', with: new_user_attributes[:password]
      click_button 'Cambiar mi contraseña'
      expect(page).to have_content('Reset password token no válido')
    end

    scenario 'different passwords and password too short' do
      visit new_user_password_path
      fill_in 'Email', with: user.email
      click_button 'CAMBIAR CONTRASEÑA'
      sleep(2)
      expect(ActionMailer::Base.deliveries.count).to eq(1)

      email = ActionMailer::Base.deliveries.last
      reset_token = email.body.to_s.match(/token=(\w+)/)[1]
      visit "/users/password/edit?reset_password_token=#{reset_token}"
      fill_in 'Nueva contraseña', with: '12345'
      fill_in 'Confirma la nueva contraseña', with: '1234567'
      click_button 'Cambiar mi contraseña'
      expect(page).to have_content('Contraseña es demasiada corta')
      expect(page).to have_content('Password confirmation no coincide')
    end
  end

  context 'with invalid email' do
    it 'show error' do
      visit new_user_password_path
      fill_in 'Email', with: 'invalid@example.com'
      click_button 'CAMBIAR CONTRASEÑA'
      expect(page).to have_content('Email no encontrado')
    end
  end
end
