## One M3Profile per yaml file upload
#
require 'json_schemer'

class M3ProfileImporter
  class_attribute :default_logger
  self.default_logger = Rails.logger
  class_attribute :default_config_file
  self.default_config_file = Dir['/app/config/metadata_profiles/*.y*ml'].first # TODO: better solution that .first?

  def self.load_profile_from_path(path: '', logger: default_logger)
    profile_config_filename = File.exist?(path) ? path : default_config_file
    raise ProfileNotFoundError, "No profiles were found in #{path}" if profile_config_filename.blank?

    logger.info("Loading with profile config #{profile_config_filename}")
    generate_from_yaml_file(path: profile_config_filename, logger: default_logger)
  end

  def self.load_profile_from_form(logger: default_logger)
    # TODO
  end

  def self.generate_from_yaml_file(path:, logger: default_logger)
    name = File.basename(path, '.*')
    data = YAML.load_file(path)
    generate_from_hash(name: name, data: data)
  rescue Psych::SyntaxError => e
    logger.error("Invalid YAML syntax found in #{path}!")
    raise YamlSyntaxError, e.message
  end

  def self.generate_from_hash(name:, data:)
    importer = new(name: name, data: data)
    profiles = importer.construct
    profiles
  end

  def initialize(name:, data:, schema: default_schema, validator: default_validator, logger: default_logger)
    self.name = name
    self.data = data
    self.schema = schema
    self.validator = validator
    @logger = logger
    validate!
  end

  # One profile per yaml file upload
  def construct
    FlexibleMetadataConstructor.find_or_create_from(name: name, data: data)
  end

  private

    attr_reader :data, :logger

    def data=(input)
      @data = input.deep_symbolize_keys
    end

    attr_accessor :name, :validator, :schema

    def default_validator
      M3ProfileValidator
    end

    def default_schema
      @schema_path    = Pathname.new('m3_profile_schema.json')
      @default_schema = JSONSchemer.schema(@schema_path)
      @default_schema
    end

    def validate!
      validator.validate(data: data, schema: schema, logger: logger)
    end

    class ProfileNotFoundError < StandardError; end
    class YamlSyntaxError < StandardError; end
end
