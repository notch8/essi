# Generated via
#  `rails generate hyrax:work PagedResource`
require 'rails_helper'

RSpec.describe Hyrax::PagedResourcesController do
  before do
    DatabaseCleaner.clean_with(:truncation)
    disable_production_minter!
    AdminSet.find_or_create_default_admin_set_id
    @allinson_flex_profile = AllinsonFlex::Importer.load_profile_from_path(path: Rails.root.join('config', 'metadata_profile', 'essi.yml'))
    @allinson_flex_profile.save
  end

  include_examples('paged_structure persister',
                   :paged_resource,
                   Hyrax::PagedResourcePresenter)
  include_examples('update metadata remotely', :paged_resource)
end
