class FlexibleMetadataConstructor
  class_attribute :default_logger
  self.default_logger = Rails.logger

  def self.find_or_create_from(name:, data:, logger: default_logger)
    profile_name = data.dig(:name) || name
    profile = M3Profile.find_or_initialize_by(name: profile_name)

    if profile.persisted? && profile.profile_version == data.dig(:profile, :version)
      if profile.profile != data
        logger.error(%(M3Profile version #{profile.profile_version} found, but the content has changed))
        raise ProfileVersionError, "This M3Profile version (#{profile.profile_version}) already exists, please increment the version number"
      end
    else
      profile.m3_version               = data.dig('m3_version')
      profile.profile_version          = data.dig('profile', 'version')
      profile.responsibility           = data.dig('profile', 'responsibility')
      profile.responsibility_statement = data.dig('profile', 'responsibility_statement')
      profile.date_modified            = data.dig('profile', 'date_modified')
      profile.profile_type             = data.dig('profile', 'type')
      profile.profile                  = data

      construct_profile_properties(profile: profile)

      profile.save!
    end

    logger.info(%(Loaded M3Profile "#{profile.name}" ID=#{profile.id}))
    profile
  end

  def self.construct_profile_properties(profile:, logger: default_logger)
    profile.profile.dig('properties').keys.each do |name|
      property = profile.properties.find_or_initialize_by(name: name)

      property.assign_attributes(
        property_uri:        profile.profile.dig('properties', name, 'property_uri'),
        cardinality_minimum: profile.profile.dig('properties', name, 'cardinality', 'minimum'),
        cardinality_maximum: profile.profile.dig('properties', name, 'cardinality', 'maximum'),
        indexing:            profile.profile.dig('properties', name, 'indexing')
      )

      logger.info(%(Constructed M3ProfileProperty "#{property.name}"))
      construct_profile_classes(profile: profile, property: property)
      property
    end
  end

  def self.construct_profile_classes(profile:, property:, logger: default_logger)
    profile.profile.dig('classes').keys.each do |name|
      profile_class = M3ProfileClass.new

      profile_class.name                   = name
      profile_class.display_label          = profile.profile.dig('classes', name, 'display_label')
      profile_class.schema_uri             = profile.profile.dig('classes', name, 'schema_uri')

      # TODO: mutates; would prefer to cascade from profile.save!
      profile.classes << profile_class
      property.available_on_classes << profile_class

      logger.info(%(Constructed M3ProfileClass "#{profile_class.name}"))
      profile_class
    end
  end

  private

    class ProfileVersionError < StandardError; end
end
