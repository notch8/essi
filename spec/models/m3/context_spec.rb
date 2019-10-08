require 'rails_helper'

RSpec.describe M3::Context, type: :model do
  let(:context) { FactoryBot.build(:m3_context) }

  it 'is valid' do
    expect(context).to be_valid
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
  describe 'associations' do
    it { should have_many(:dynamic_schemas).class_name('M3::DynamicSchema') }
    it { should belong_to(:m3_profile).class_name('M3::Profile') }
  end
  describe 'serializations' do
    it { should serialize(:admin_set_ids).as(Array) }
  end
end
