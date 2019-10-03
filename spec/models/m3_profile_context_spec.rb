require 'rails_helper'

RSpec.describe M3ProfileContext, type: :model do
  describe 'associations' do
    it 'belongs_to m3_profile' do
      assc = described_class.reflect_on_association(:m3_profile)
      expect(assc.macro).to eq :belongs_to
    end

    it 'has_many texts' do
      assc = described_class.reflect_on_association(:context_texts)
      expect(assc.macro).to eq :has_many
    end
  end

  it 'is valid' do
    context = FactoryBot.build(:m3_profile_context)
    expect(context).to be_valid
  end
end
