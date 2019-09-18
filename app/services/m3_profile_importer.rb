require 'json_schemer'

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
      validator.call(data: data, schema: schema, logger: logger)
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
      workflow = Sipity::Workflow.find_or_initialize_by(name: configuration.fetch(:name))
      generate_state_diagram!(workflow: workflow, actions_configuration: configuration.fetch(:actions))

      find_or_create_workflow_permissions!(
        workflow: workflow, workflow_permissions_configuration: configuration.fetch(:workflow_permissions, [])
      )
      workflow.label = configuration.fetch(:label, nil)
      workflow.description = configuration.fetch(:description, nil)
      workflow.allows_access_grant = configuration.fetch(:allows_access_grant, nil)
      workflow.save!
      logger.info(%(Loaded Sipity::Workflow "#{workflow.name}" for #{permission_template.class} ID=#{permission_template.id}))
      workflow
    end

end
