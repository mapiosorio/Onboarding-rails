require 'rails_helper'

RSpec.describe Provider, type: :model do
  it 'has a valid factory' do
    expect(build(:provider)).to be_valid
  end

  describe 'associations' do
    it { is_expected.to have_many :products }
  end
end
