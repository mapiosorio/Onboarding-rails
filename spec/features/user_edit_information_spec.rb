require 'rails_helper'
require 'devise'

RSpec.feature 'user edit personal information', type: :feature do
  let!(:user) { create(:user) }

  context 'with logged user' do
    it 'changes the information' do
      sign_in user
      visit edit_user_registration_path

      attach_file('Foto de perfil', File.absolute_path('app/assets/images/profile_picture.png'))
      fill_in 'Nombre', with: 'name'
      fill_in 'Apellido', with: 'surname'
      fill_in 'Contraseña actual', with: user.password
      fill_in 'Número de contacto', with: 99_999_999
      click_button 'Editar información'

      expect(page).to have_current_path(root_path)
      user.reload

      expect(user.photo).to be_present
      expect(user.name).to eq('name')
      expect(user.surname).to eq('surname')
      expect(user.phone_number).to eq(99_999_999)
    end
  end

  context 'without log in user' do
    it 'redirects to sign in' do
      visit edit_user_registration_path
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
