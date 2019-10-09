require 'rails_helper'

RSpec.describe M3::ProfileContext, type: :model do
  let(:profile_context) { FactoryBot.build(:m3_profile_context) }

  it 'is valid' do
    expect(profile_context).to be_valid
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:display_label) }
  end
  describe 'associations' do
    it { should have_many(:context_texts).class_name('M3::ProfileText') }
    it { should have_many(:properties).class_name('M3::ProfileProperty').through(:available_properties) }
  end
end
