require 'rails_helper'

RSpec.describe Additional, type: :model do
  it 'has  a valid factory' do
    expect(build(:additional)).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:description) }
  end
end
