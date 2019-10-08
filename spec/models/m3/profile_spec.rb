require 'rails_helper'

RSpec.describe M3::Profile, type: :model do
  let(:profile) { FactoryBot.build(:m3_profile) }

  it 'is valid' do
    expect(profile).to be_valid
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:profile) }
    it { should validate_presence_of(:profile_version) }
    it { should validate_presence_of(:date_modified) }
    it { should validate_presence_of(:responsibility) }
  end
  describe 'associations' do
    it { should have_many(:dynamic_schemas).class_name('M3::DynamicSchema') }
    it { should have_many(:m3_contexts).class_name('M3::Context') }
    it { should have_many(:classes).class_name('M3::ProfileClass') }
    it { should have_many(:contexts).class_name('M3::ProfileContext') }
    it { should have_many(:properties).class_name('M3::ProfileProperty') }
  end
  describe 'serializations' do
    it { should serialize(:profile) }
  end
end
