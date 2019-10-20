require 'rails_helper'

RSpec.describe M3::Importer do
  describe '#load_profile_from_path' do
    let(:profile) { M3::Importer.load_profile_from_path(path: File.join(RSpec.configuration.fixture_path, 'files/yaml_example.yaml')) }

    it 'returns valid with a valid path' do
      expect(profile)
        .to be_valid
    end

    it 'returns valid without a specified path' do
      expect(M3::Importer.load_profile_from_path)
        .to be_valid
    end

    it 'raises an error with an invalid file' do
      expect { M3::Importer.load_profile_from_path(path: 'app/models/m3/profile.rb') }
        .to raise_error(M3::Importer::YamlSyntaxError)
    end

    it 'uses default config file when path is not a file' do
      expect(profile)
        .to be_an_instance_of(M3::Profile)
    end

    it 'returns an M3::Profile instance' do
      expect(profile)
        .to be_an_instance_of(M3::Profile)
    end

    it 'creates associated dynamic_schema objects, including defualt' do
      expect(profile.dynamic_schemas.count)
        .to eq(2)
    end

    it 'creates associated m3_context objects, including default' do
      expect(profile.m3_contexts.count)
        .to eq(2)
    end
  end

  describe 'class attributes' do
    it '#default_logger' do
      M3::Importer.default_logger == Rails.logger
    end

    it '#default_config_file' do
      path_to_file = M3::Importer.default_config_file
      expect(path_to_file).to include('config/metadata_profiles/')
    end
  end
end
