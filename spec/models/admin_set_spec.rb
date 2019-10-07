require 'rails_helper'
RSpec.describe AdminSet, type: :model do

  subject { described_class.new(title: ['Some title']) }

  describe '#metadata_context' do
    it 'leverages M3Context.find_metadata_context_for' do
      admin_set = build(:admin_set, id: 1234)
      expect(M3Context).to receive(:find_metadata_context_for).with(admin_set_id: admin_set.id).and_return(:context)
      expect(admin_set.metadata_context).to eq(:context)
    end
  end

end
