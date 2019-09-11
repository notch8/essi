class M3ProfileImporter
  class_attribute :default_logger
  self.default_logger = Rails.logger
  class_attribute :path_to_profile_files
  self.path_to_profile_files = Rails.root.join('config', 'metadata_profiles', '*.yaml')

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
    # generate_from_hash(data: data, **keywords)
  end

  # def self.generate_from_hash(data:, **keywords)
    # importer = new(data: data, **keywords)
    # profiles = importer.call
    # self.load_errors ||= []
    # load_errors.concat(importer.errors)
    # profiles
  # end

  # def initialize(data:, schema: default_schema, validator: default_validator, logger: default_logger)
    # self.data = data
    # self.schema = schema
    # self.validator = validator
    # @logger = logger
    # validate!
  # end
end
