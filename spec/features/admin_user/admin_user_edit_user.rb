require 'rails_helper'

RSpec.describe 'edit users', type: :feature do
  let!(:admin_user) { create(:admin_user) }
  let!(:user) { create(:user) }

  before do
    login_as(admin_user)
  end

  it 'edits the user' do
    visit edit_admin_user_path(user.id)

    fill_in 'Nombre', with: 'Maria Paz'
    fill_in 'Apellido', with: 'Osorio'
    click_button 'Guardar User'

    expect(page).to have_current_path(admin_user_path(user.id))

    expect(page).to have_content('Maria Paz')
    expect(page).to have_content('Osorio')
  end
end
