require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:product)).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:supplier) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:supplier) }
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:rating) }
  end
end
