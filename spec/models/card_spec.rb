require 'rails_helper'

RSpec.describe Card, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:card)).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:orders) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:expiration_date) }
    it { is_expected.to validate_presence_of(:cardholder) }
    it { is_expected.to validate_presence_of(:cvv) }
  end
end
