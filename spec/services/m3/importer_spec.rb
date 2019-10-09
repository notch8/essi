require 'rails_helper'

RSpec.describe M3::Importer do

  describe 'class attributes' do
    it '#default_logger' do
      M3::Importer.default_logger == Rails.logger
    end

    it '#default_config_file' do
      path_to_file = M3::Importer.default_config_file
      expect(path_to_file).to include('config/metadata_profiles/')
    end
  end

  describe '#load_profile_from_path' do
    it 'returns an M3::Profile instance' do
      expect(M3::Importer.load_profile_from_path)
        .to be_an_instance_of(M3::Profile)
    end
  end

end
