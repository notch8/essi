require 'rails_helper'

RSpec.describe "hyrax/base/_structure_node.html.erb" do
  let(:node) do
    WithProxyForObject::Factory.new([member]).new(params)
  end
  let(:params) do
    {
      "proxy": "a"
    }
  end
  let(:member) do
    endpoint = IIIFManifest::IIIFEndpoint.new('info_url', profile: Hyrax.config.iiif_image_compliance_level_uri)
    display_image = IIIFManifest::DisplayImage.new('display_url', width: 640, height: 480, iiif_endpoint: endpoint)
    instance_double(Hyrax::FileSetPresenter, id: 'a', display_image: display_image)
  end

  before do
    render partial: 'hyrax/base/structure_node',
           locals: { node: node }
  end
  it "displays an openseadragon tag for proxies" do
    expect(rendered).to have_selector(
      "*[data-modal-manifest='info_url/info.json']"
    )
  end
end
