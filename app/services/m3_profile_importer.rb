require 'json_schemer'

class M3ProfileImporter
  class_attribute :default_logger
  self.default_logger = Rails.logger
  class_attribute :path_to_profile_files
  self.path_to_profile_files = Rails.root.join('config', 'metadata_profiles', '*.yaml')

  class << self
    attr_reader :load_errors

      private

        attr_writer :load_errors
  end

  def self.load_profiles(logger: default_logger)
    profile_config_filenames = Dir.glob(path_to_profile_files)
    if profile_config_filenames.none?
      logger.info("No profiles were found in #{path_to_profile_files}")
      return false
    end
    profile_config_filenames.each do |config|
      logger.info "Loading with profile config #{config}"
      generate_from_yaml_file(path: config, logger: default_logger)
    end
    true
  end

  def self.generate_from_yaml_file(path:, **keywords)
    data = YAML.load_file(path)
    generate_from_hash(data: data, **keywords)
  end

  def self.generate_from_hash(data:, **keywords)
    importer = new(data: data, **keywords)
    profiles = importer.call
    self.load_errors ||= []
    load_errors.concat(importer.errors)
    profiles
  end

  def initialize(data:, schema: default_schema, validator: default_validator, logger: default_logger)
    self.data = data
    self.schema = schema
    self.validator = validator
    @logger = logger
    validate!
  end

  private

    attr_reader :data, :logger

    def data=(input)
      @data = input.deep_symbolize_keys
    end

    attr_accessor :validator, :schema

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

  public

  attr_accessor :errors

  def call
    self.errors = []
    Array.wrap(data.fetch(:profile)).map do |configuration|
      find_or_create_from(configuration: configuration)
    end
  end

  private

  def find_or_create_from(configuration:)
      profile = M3Profile.find_or_initialize_by(name: configuration.fetch(:name))

      profile.profile_version = configuration.fetch(:profile_version, nil)
      profile.profile = configuration.fetch(:data, nil)
      profile.save!

      logger.info(%(Loaded M3Profile "#{profile.name}" ID=#{profile.id}))
      profile
    end

end
