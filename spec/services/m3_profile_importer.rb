require 'rails_helper'

RSpec.describe M3ProfileImporter do

  describe 'class attributes' do
    it '#default_logger' do
      M3ProfileImporter.default_logger == Rails.logger
    end

    it '#default_config_file' do
      path_to_file = M3ProfileImporter.default_config_file
      expect(path_to_file).to include('config/metadata_profiles/')
    end
  end

  describe '#load_profile_from_path' do
    it 'returns an M3Profile instance' do
      expect(M3ProfileImporter.load_profile_from_path)
        .to be_an_instance_of(M3Profile)
    end
  end

end
