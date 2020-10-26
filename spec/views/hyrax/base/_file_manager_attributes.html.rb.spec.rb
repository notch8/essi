require 'rails_helper'

RSpec.describe 'hyrax/base/_file_manager_attributes.html.erb' do
  it 'displays an OCR indicator' do
    node = FileSet.create!
    render partial: 'hyrax/base/file_manager_attributes.html.erb', locals: {node: node}
    expect(rendered).to have_content('OCR Text Available:')
  end
end
