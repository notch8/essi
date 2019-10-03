require 'rails_helper'

RSpec.describe M3ProfileText, type: :model do
  describe 'associations' do
    it 'belongs_to m3_profile_property' do
      assc = described_class.reflect_on_association(:property)
      expect(assc.macro).to eq :belongs_to
    end

    it 'belongs_to textable' do
      assc = described_class.reflect_on_association(:textable)
      expect(assc.macro).to eq :belongs_to
    end
  end

  it 'is valid' do
    m3text = FactoryBot.build(:m3_profile_text)
    expect(m3text).to be_valid
  end
end
