require 'rails_helper'

RSpec.describe 'create user', type: :feature do
  let!(:admin_user) { create(:admin_user) }
  let!(:new_user_attributes) { attributes_for(:user) }

  before do
    login_as(admin_user)
  end

  it 'creates the user' do
    visit new_admin_user_path

    fill_in 'Nombre', with: new_user_attributes[:name]
    fill_in 'Apellido', with: new_user_attributes[:surname]
    fill_in 'Email', with: new_user_attributes[:email]
    fill_in 'Empresa', with: new_user_attributes[:company]
    fill_in 'Position', with: new_user_attributes[:position]
    fill_in 'Contraseña', with: new_user_attributes[:password]
    click_button 'Guardar User'

    expect(page).to have_current_path(admin_user_path(User.last))
  end
end
