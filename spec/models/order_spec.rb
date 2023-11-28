require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:order)).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:card) }
    it { is_expected.to have_and_belong_to_many(:additionals) }
    it { is_expected.to have_one_attached(:company_logo) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:total) }
    it { is_expected.to validate_presence_of(:subtotal) }
    it { is_expected.to validate_presence_of(:taxes) }
    it { is_expected.to validate_presence_of(:delivery_date) }
    it { is_expected.to validate_presence_of(:delivery_time) }
    it { is_expected.to validate_presence_of(:recipient_name) }
    it { is_expected.to validate_presence_of(:recipient_phone_number) }
    it { is_expected.to validate_presence_of(:rut) }
    it { is_expected.to validate_presence_of(:company_name) }
    it { is_expected.to validate_presence_of(:delivery_direction) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0) }
  end
end
