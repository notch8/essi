require 'rails_helper'
RSpec.describe 'hyrax/admin/admin_sets/_form_metadata_context.html.erb', type: :view do
  let(:template) { stub_model(Hyrax::PermissionTemplate) }
  let(:m3_context) { build(:m3_context) }
  let(:pt_form) do
    instance_double(Hyrax::Forms::PermissionTemplateForm,
                    model_name: template.model_name,
                    persisted?: template.persisted?,
                    to_key: template.to_key,
                    available_contexts: [m3_context],
                    metadata_context_options: [[m3_context.id, m3_context.name]])
  end

  before do
    @form = instance_double(Hyrax::Forms::AdminSetForm,
                            to_model: stub_model(AdminSet),
                            permission_template: pt_form)
    render
  end
  it 'has the drop down for metadata_context' do
    expect(rendered).to have_selector('#metadata_context')
    expect(rendered).to have_selector("option[value=\"#{m3_context.name}\"]")
  end
end