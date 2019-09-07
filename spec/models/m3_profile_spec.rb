require 'rails_helper'

RSpec.describe M3Profile, type: :model do
<<<<<<< HEAD
<<<<<<< HEAD
=======
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
  end

  it 'is valid' do
    profile = FactoryBot.build(:m3_profile)
    expect(profile).to be_valid
  end
<<<<<<< HEAD

  describe '#profile' do
    it 'is a Hash' do
      profile = FactoryBot.build(:m3_profile)
      expect(profile.profile.class).to eq Hash
    end
  end
=======
  pending "add some examples to (or delete) #{__FILE__}"
>>>>>>> generate m3 and dynamic schema models / migrations
=======
>>>>>>> flexible metadata model factories / specs
end
