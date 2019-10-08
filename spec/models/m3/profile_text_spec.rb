require 'rails_helper'

RSpec.describe M3::ProfileText, type: :model do
  let(:profile_text) { FactoryBot.build(:m3_profile_text) }

  it 'is valid' do
    expect(profile_text).to be_valid
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:value) }
  end
  describe 'associations' do
    it { should belong_to(:textable).optional }
    it { should belong_to(:textable).optional }
  end
end
