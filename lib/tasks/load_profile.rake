
# @todo - make this more sophisticated
namespace :m3 do
  desc 'Create the profile in config/metadata_profile'
  task load_profile: :environment do
    M3::Importer.load_profile_from_path
  end
end
