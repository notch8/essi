# Generated via
#  `rails generate hyrax:work PagedResource`
require 'spec_helper'
require 'rails_helper'

RSpec.describe Hyrax::Actors::PagedResourceActor do
  let(:work) { FactoryBot.create(:paged_resource_with_one_image) }
  let(:ability) { ::Ability.new(user) }
  let(:env) { Hyrax::Actors::Environment.new(work, ability, attributes) }
  let(:terminator) { Hyrax::Actors::Terminator.new }
  let(:user)     { FactoryBot.create(:user) }
  let(:attributes) { {} }

  subject(:middleware) do
    stack = ActionDispatch::MiddlewareStack.new.tap do |middleware|
      middleware.use described_class
    end
    stack.build(terminator)
  end

  describe "#create" do
    before do
      DatabaseCleaner.clean_with(:truncation)
      disable_production_minter!
      AdminSet.find_or_create_default_admin_set_id
      @allinson_flex_profile = AllinsonFlex::Importer.load_profile_from_path(path: Rails.root.join('config', 'metadata_profile', 'essi.yml'))
      @allinson_flex_profile.save
    end

    context 'when index_ocr_files is true', :clean do
      it 'OCR should be searchable' do
        allow(ESSI.config).to receive(:dig) \
        .with(any_args).and_call_original
        allow(ESSI.config).to receive(:dig) \
        .with(:essi, :index_ocr_files) \
        .and_return(true)
        expect { middleware.create(env) }.to change { work.ocr_state }.from(nil).to("searchable")
      end
    end

    context 'when index_ocr_files is false', :clean do
      it 'OCR should not be searchable' do
        allow(ESSI.config).to receive(:dig) \
        .with(any_args).and_call_original
        allow(ESSI.config).to receive(:dig) \
        .with(:essi, :index_ocr_files) \
        .and_return(false)
        expect { middleware.create(env) }.not_to change { work.ocr_state }
      end
    end
  end
end
