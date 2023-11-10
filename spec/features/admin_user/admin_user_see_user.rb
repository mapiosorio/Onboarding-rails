require 'rails_helper'

RSpec.describe 'see users', type: :feature do
  let!(:admin_user) { create(:admin_user) }

  before do
    login_as(admin_user)
  end

  it 'display a list of users' do
    user1 = create(:user)
    user2 = create(:user)
    user3 = create(:user)

    visit admin_users_path

    expect(page).to have_content(user1.email)
    expect(page).to have_content(user2.email)
    expect(page).to have_content(user3.email)
  end
end
