require 'rails_helper'

RSpec.feature 'reset password' do
  let!(:user) { create(:user) }
  let(:new_user_attributes) { attributes_for(:user) }

  context 'with valid email' do
    scenario 'success' do
      visit new_user_password_path

      fill_in 'Email', with: user.email
      click_button 'CAMBIAR CONTRASEÑA'

      expect(page).to have_current_path(new_user_session_path)
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

      expect(page).to have_current_path(new_user_session_path)
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
      expect(page).to have_content('Las contraseñas no coinciden')
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
