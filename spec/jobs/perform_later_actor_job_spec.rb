require 'rails_helper'

describe PerformLaterActorJob do
  let(:action) { 'arbitrary' }
  let(:ability_user) { FactoryBot.create(:user) }
  let(:attributes_for_actor) { {'title': 'A Title for Future Me'} }
  let(:actor_stack) { double 'actor stack' }

  describe '#perform' do
    subject { described_class.perform_now(action, curation_concern, @ability_user, attributes_for_actor) }

    before do
      DatabaseCleaner.clean_with(:truncation)
      disable_production_minter!
      AdminSet.find_or_create_default_admin_set_id
      @allinson_flex_profile = AllinsonFlex::Importer.load_profile_from_path(path: Rails.root.join('config', 'metadata_profile', 'essi.yml'))
      @allinson_flex_profile.save
      allow(Hyrax::CurationConcern).to receive(:actor).and_return actor_stack
    end

    context 'with a curation_concern class string' do
      let(:curation_concern) { 'PagedResource' }

      it 'calls the actor stack with an actor environment' do
        expect(actor_stack).to receive(:arbitrary).with(instance_of(Hyrax::Actors::Environment))
        subject
      end

      it 'calls the actor stack using a new curation_concern instance' do
        expect(actor_stack).to receive(:arbitrary).with(having_attributes(:curation_concern => instance_of(PagedResource)))
        subject
      end
    end

    context 'with a curation_concern instance' do
      let(:curation_concern) { FactoryBot.create(:paged_resource) }

      it 'calls the actor stack with an actor environment' do
        expect(actor_stack).to receive(:arbitrary).with(instance_of(Hyrax::Actors::Environment))
        subject
      end

      it 'calls the actor stack using the existing curation_concern instance' do
        expect(actor_stack).to receive(:arbitrary).with(having_attributes(:curation_concern => curation_concern))
        subject
      end
    end
  end
end
