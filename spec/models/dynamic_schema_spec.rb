require 'rails_helper'

RSpec.describe DynamicSchema, type: :model do
  describe 'associations' do
    it 'belongs_to a m3_context' do
      assc = described_class.reflect_on_association(:m3_context)
      expect(assc.macro).to eq :belongs_to
    end

    it 'belongs_to a m3_profile' do
      assc = described_class.reflect_on_association(:m3_profile)
      expect(assc.macro).to eq :belongs_to
    end
  end

  it 'is valid' do
    dynamic_schema = FactoryBot.build(:dynamic_schema)
    expect(dynamic_schema).to be_valid
  end

  describe '#schema' do
    it 'is a Hash' do
      dynamic_schema = FactoryBot.build(:dynamic_schema)
      expect(dynamic_schema.schema.class).to eq Hash
    end
  end
end
