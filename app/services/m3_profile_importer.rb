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
    # replace w/ path
    profile_config_filenames.each do |config|
      logger.info "Loading with profile config #{config}"
      generate_from_yaml_file(path: config, logger: default_logger)
    end
    true
  end

  def self.generate_from_yaml_file(path:, logger: default_logger, **keywords)
    data = YAML.load_file(path)
    generate_from_hash(data: data, **keywords)
  rescue Psych::SyntaxError => e
    logger.error("Invalid YAML syntax found in #{path}!")
    logger.error(e.message)
    raise e
  end

  def self.generate_from_hash(data:, **keywords)
    importer = new(data: data, **keywords)
    profiles = importer.call
    profiles
  end

  def initialize(data:, schema: default_schema, validator: default_validator, logger: default_logger)
    self.data = data
    self.schema = schema
    self.validator = validator
    @logger = logger
    validate!
  end

  # One profile per yaml file upload
  def call
    find_or_create_from(data: data)
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

    def find_or_create_from(data:)
      profile = M3Profile.find_or_initialize_by(name: data.fetch(:name))

      if profile.persisted? && profile.profile_version == data.fetch(:profile_version)
        if profile.profile != data
          logger.error(%(This M3Profile version (#{profile.profile_version}) already exists, please increment the version number))
          raise M3ImporterError
        end
      else
        profile.profile_version = data.fetch(:profile_version, nil)
        profile.profile = data
        profile.save!
      end

      logger.info(%(Loaded M3Profile "#{profile.name}" ID=#{profile.id}))
      profile
    end

    class M3ImporterError < StandardError
      def message
        'This M3Profile version already exists, please increment the version number'
      end
    end
end
