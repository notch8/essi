require 'rails_helper'
RSpec.describe 'hyrax/admin/admin_sets/_form.html.erb', type: :view do
  let(:admin_set) { stub_model(AdminSet) }
  let(:form) { Hyrax::Forms::AdminSetForm.new(admin_set, double, double) }

  before do
    assign(:form, form)
    stub_template('hyrax/admin/admin_sets/_form_metadata_context.html.erb' => 'metadata_context tab')
    render
  end

  it 'has metadata_context tab' do
    expect(rendered).to have_content('metadata_context')
  end
end
