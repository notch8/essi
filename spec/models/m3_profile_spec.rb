require 'rails_helper'

RSpec.describe M3Profile, type: :model do
<<<<<<< HEAD
<<<<<<< HEAD
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:profile) }
  end
=======
<<<<<<< HEAD
>>>>>>> generate m3 and dynamic schema models / migrations
=======
<<<<<<< HEAD
=======
>>>>>>> flexible metadata model factories / specs
>>>>>>> flexible metadata model factories / specs
  describe 'associations' do
    it 'has_many m3_contexts' do
      assc = described_class.reflect_on_association(:m3_contexts)
      expect(assc.macro).to eq :has_many
    end

    it 'has_many dynamic_schemas' do
      assc = described_class.reflect_on_association(:dynamic_schemas)
      expect(assc.macro).to eq :has_many
    end
    it 'has_many classes' do
      assc = described_class.reflect_on_association(:classes)
      expect(assc.macro).to eq :has_many
    end
    it 'has_many contexts' do
      assc = described_class.reflect_on_association(:contexts)
      expect(assc.macro).to eq :has_many
    end
    it 'has_many properties' do
      assc = described_class.reflect_on_association(:properties)
      expect(assc.macro).to eq :has_many
    end
  end

  it 'is valid' do
    profile = FactoryBot.build(:m3_profile)
    expect(profile).to be_valid
  end
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> test serialized fields, populate factories with better example data

  describe '#profile' do
    it 'is a Hash' do
      profile = FactoryBot.build(:m3_profile)
      expect(profile.profile.class).to eq Hash
    end
  end
<<<<<<< HEAD
=======
  pending "add some examples to (or delete) #{__FILE__}"
>>>>>>> generate m3 and dynamic schema models / migrations
=======
>>>>>>> flexible metadata model factories / specs
=======
>>>>>>> test serialized fields, populate factories with better example data
end
