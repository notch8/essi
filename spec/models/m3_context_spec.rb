require 'rails_helper'

RSpec.describe M3Context, type: :model do
<<<<<<< HEAD
  describe 'associations' do
    it 'belongs_to a m3_profile' do
      assc = described_class.reflect_on_association(:m3_profile)
      expect(assc.macro).to eq :belongs_to
    end

    it 'has_many dynamic_schemas' do
      assc = described_class.reflect_on_association(:dynamic_schemas)
      expect(assc.macro).to eq :has_many
    end
  end

  it 'is valid' do
    context = FactoryBot.build(:m3_context)
    expect(context).to be_valid
  end
=======
  pending "add some examples to (or delete) #{__FILE__}"
>>>>>>> generate m3 and dynamic schema models / migrations
end
