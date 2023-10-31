require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  it 'has a valid factory' do
    expect(build(:admin_user)).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end
end
