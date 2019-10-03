require 'rails_helper'

RSpec.describe M3ProfileClass, type: :model do
  describe 'associations' do
    it 'belongs_to m3_profile' do
      assc = described_class.reflect_on_association(:m3_profile)
      expect(assc.macro).to eq :belongs_to
    end

    it 'has_many m3_profile_contexts' do
      assc = described_class.reflect_on_association(:contexts)
      expect(assc.macro).to eq :has_many
    end

    it 'has_many texts' do
      assc = described_class.reflect_on_association(:class_texts)
      expect(assc.macro).to eq :has_many
    end
  end

  it 'is valid' do
    m3class = FactoryBot.build(:m3_profile_class)
    expect(m3class).to be_valid
  end
end
