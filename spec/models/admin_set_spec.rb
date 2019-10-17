require 'rails_helper'
RSpec.describe AdminSet, type: :model do
  subject { described_class.new(title: ['Some title']) }
  let(:admin_set) { create(:admin_set, id: rand(10).to_s) }
  let(:m3_context) { create(:m3_context, admin_set_ids: [admin_set.id]) }

  describe '#metadata_context' do
    it 'uses M3::Context.find_metadata_context_for' do
      expect(M3::Context).to receive(:find_metadata_context_for).with(admin_set_id: admin_set.id).and_return(m3_context)
      expect(admin_set.metadata_context).to eq(m3_context)
    end
  end

  describe '#remove_from_m3_context' do
    before do
      allow(M3::Context).to receive(:find_metadata_context_for).with(admin_set_id: admin_set.id).and_return(m3_context)
      admin_set.remove_from_m3_context
    end

    it 'removes the admin_set_id from the context' do
      expect(m3_context.admin_set_ids).to eq([])
    end
  end
end
