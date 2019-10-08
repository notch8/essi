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

      construct_profile_classes(profile: profile)

      profile.save!
    end

    logger.info(%(Loaded M3Profile "#{profile.name}" ID=#{profile.id}))
    profile
  end

  def self.construct_profile_properties(profile:, profile_class:, logger: default_logger)
    properties_hash = profile.profile.dig('properties')

    properties_hash.keys.each do |name|
      property = profile.properties.find_or_initialize_by(name: name)

      property.assign_attributes(
        property_uri:        properties_hash.dig(name, 'property_uri'),
        cardinality_minimum: properties_hash.dig(name, 'cardinality', 'minimum'),
        cardinality_maximum: properties_hash.dig(name, 'cardinality', 'maximum'),
        indexing:            properties_hash.dig(name, 'indexing')
      )
      logger.info(%(Constructed M3ProfileProperty "#{property.name}"))

      property.available_on_classes << profile_class

      property
    end
  end

  def self.construct_profile_classes(profile:, logger: default_logger)
    profile_classes_hash = profile.profile.dig('classes')

    profile_classes_hash.keys.each do |name|
      profile_class = profile.classes.find_or_initialize_by(name: name)

      profile_class.assign_attributes(
        display_label:          profile_classes_hash.dig(name, 'display_label'),
        schema_uri:             profile_classes_hash.dig(name, 'schema_uri')
      )
      logger.info(%(Constructed M3ProfileClass "#{profile_class.name}"))

      construct_profile_properties(profile: profile, profile_class: profile_class)

      profile_class
    end
  end

  private

    class ProfileVersionError < StandardError; end
end
