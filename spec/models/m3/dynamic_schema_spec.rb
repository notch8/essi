require 'rails_helper'

RSpec.describe M3::DynamicSchema, type: :model do
  let(:dynamic_schema) { FactoryBot.build(:dynamic_schema) }

  it 'is valid' do
    expect(dynamic_schema).to be_valid
  end
  describe 'validations' do
    it { should validate_presence_of(:m3_class) }
    it { should validate_presence_of(:schema) }
  end
  describe 'associations' do
    it { should belong_to(:m3_context).class_name('M3::Context') }
    it { should belong_to(:m3_profile).class_name('M3::Profile') }
  end
  describe 'serializations' do
    it { should serialize(:schema) }
  end
end
