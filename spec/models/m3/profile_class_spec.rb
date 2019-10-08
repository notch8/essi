require 'rails_helper'

RSpec.describe M3::ProfileClass, type: :model do
  let(:profile_class) { FactoryBot.build(:m3_profile_class) }

  it 'is valid' do
    expect(profile_class).to be_valid
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:display_label) }
  end
  describe 'associations' do
    it { should have_many(:contexts).class_name('M3::ProfileContext') }
    it { should have_many(:class_texts).class_name('M3::ProfileText') }
  end
end
