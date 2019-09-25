require 'rails_helper'

RSpec.describe Hyrax::Forms::PermissionTemplateForm do

  let(:form) { described_class.new(permission_template) }
  let(:permission_template) { build(:permission_template) }
  let(:m3_context) { create(:m3_context) }

  subject { form }

  describe '#update' do
    subject { form.update(input_params) }
    
    let(:input_params) { ActionController::Parameters.new(metadata_context_id: m3_context.id.to_s).permit! }
    let(:permission_template) { create(:permission_template, with_admin_set: true, with_workflows: true) }
    
    it 'updates the metadata_context with the admin_set id' do
      expect(form).to receive(:update_metadata_context)
      form.update(input_params)
    end

    it 'sets the tab to metadata_context' do
      expect(subject[:content_tab]).to eq('metadata_context')
    end
  end

  describe '#metadata_context_options' do
    subject { form.metadata_context_options }

    before do
      allow(M3Context).to receive(:available_contexts).and_return([m3_context])
    end

    it 'returns a collection of m3_context id/name arrays' do
      expect(subject).to eq([[m3_context.name,m3_context.id]])
    end
  end
end