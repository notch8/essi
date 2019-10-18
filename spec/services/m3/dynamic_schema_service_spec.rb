require 'rails_helper'

RSpec.describe M3::DynamicSchemaService do
  let(:service_class) { described_class }
  let(:admin_set_id) { AdminSet.find_or_create_default_admin_set_id }
  let(:service) do
    service_class.new(
      admin_set_id: admin_set_id,
      curation_concern_class_name: 'Image'
    )
  end
  let(:m3_context) { create(:m3_context_assigned) }
  let(:dynamic_schema) { create(:dynamic_schema) }

  before do
    allow(AdminSet).to receive_message_chain(:find, :metadata_context).and_return(m3_context)
    allow(M3::DynamicSchema).to receive(:where).with(m3_context: m3_context.id).and_return([dynamic_schema])
  end

  describe '#new' do
    context 'admin_set does not have a metadata_context' do
      let(:m3_context) { create(:m3_context) }

      it 'raises a custom error' do
        expect do
          service_class.new(
            admin_set_id: admin_set_id,
            curation_concern_class_name: 'Image'
          ).to raise(M3::NoM3ContextError)
        end
      end
    end

    context 'admin_set has a metadata_context' do
      it 'returns the dynamic_schema schema' do
        expect(service.dynamic_schema).to be_a(Hash)
      end
    end
  end

  describe 'methods' do
    context 'models' do
      it 'returns the properties for the model' do
        expect(service.model_properties.keys).to eq([:title])
        expect(service.model_properties[:title]).to be_a(ActiveFedora::Attributes::NodeConfig)
      end
      it 'returns the rdf-type for the model' do
        expect(service.rdf_type.to_s).to eq('http://example.com/classes/Image')
      end
    end

    context 'indexers' do
      it 'returns the fields to index' do
        expect(service.indexing_properties).to eq(title: %w[title_tesim title_ssm])
      end
    end

    context 'forms / presenters' do
      it 'returns the property names' do
        expect(service.properties).to eq([:title])
      end
      it 'returns the required fields' do
        expect(service.required_properties).to eq([:title])
      end
    end

    context 'solr_document' do
      it 'returns the solr_attributes' do
        expect(service.solr_attributes).to eq([{ title: false }])
      end
    end

    context 'solr_document' do
      it 'returns the solr_attributes' do
        expect(service.solr_attributes).to eq([{ title: false }])
      end
    end

    context 'views' do
      it 'returns the view properties for drawing on _attributes.html.erb' do
        expect(service.view_properties).to eq([{ title: { label: 'Title in Context' }}])
      end
    end

    context 'locales' do
      it 'returns the ' do
        expect(service.property_locale(:title, 'label')).to eq('Title in Context')
      end
    end
  end
end
