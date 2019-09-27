require 'rails_helper'

RSpec.describe M3ProfileProperty, type: :model do
  describe 'associations' do
    it 'belongs_to m3_profile' do
      assc = described_class.reflect_on_association(:m3_profile)
      expect(assc.macro).to eq :belongs_to
    end

    it 'has_many available_on_class' do
      assc = described_class.reflect_on_association(:available_on_classes)
      expect(assc.macro).to eq :has_many
    end
    it 'has_many available_on_context' do
      assc = described_class.reflect_on_association(:available_on_contexts)
      expect(assc.macro).to eq :has_many
    end
    it 'has_many texts' do
      assc = described_class.reflect_on_association(:texts)
      expect(assc.macro).to eq :has_many
    end
  end

  it 'is valid' do
    prop = FactoryBot.build(:m3_profile_property)
    expect(prop).to be_valid
  end
end
