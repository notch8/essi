## One M3Profile per yaml file upload
#
require 'json_schemer'

class M3ProfileImporter
  class_attribute :default_logger
  self.default_logger = Rails.logger
  class_attribute :path_to_profile_files
  self.path_to_profile_files = Rails.root.join('config', 'metadata_profiles', '*.y*ml')

  def self.load_profiles(logger: default_logger)
    profile_config_filenames = Dir.glob(path_to_profile_files)
    if profile_config_filenames.none?
      logger.info("No profiles were found in #{path_to_profile_files}")
      return false
    end
    # TODO: replace w/ path
    profile_config_filenames.each do |config|
      logger.info "Loading with profile config #{config}"
      generate_from_yaml_file(path: config, logger: default_logger)
    end
    true
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

    class YamlSyntaxError < StandardError; end
end
