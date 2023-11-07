require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:product)).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:provider) }
    it { is_expected.to have_and_belong_to_many(:additionals) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:provider) }
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:rating) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
  end
end
