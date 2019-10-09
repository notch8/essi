module M3
  class FlexibleMetadataConstructor
    class_attribute :default_logger
    self.default_logger = Rails.logger

    def self.find_or_create_from(name:, data:, logger: default_logger)
      profile_name = data.dig('name') || name
      profile_match = M3::Profile.where(name: profile_name, profile_version: data.dig('profile', 'version')).first

      if profile_match.blank?
        profile = M3::Profile.new(
          name:                     profile_name,
          m3_version:               data.dig('m3_version'),
          profile_version:          data.dig('profile', 'version'),
          responsibility:           data.dig('profile', 'responsibility'),
          responsibility_statement: data.dig('profile', 'responsibility_statement'),
          date_modified:            data.dig('profile', 'date_modified'),
          profile_type:             data.dig('profile', 'type'),
          profile:                  data
        )

        construct_profile_contexts(profile: profile)

        profile.save!
        logger.info(%(Loaded M3::Profile "#{profile.name}" ID=#{profile.id}))

        profile
      else
        if profile_match.profile != data
          logger.error(%(\nM3::Profile version #{profile_match.profile_version} found, but the content has changed))
          raise ProfileVersionError, "This M3::Profile version (#{profile_match.profile_version}) already exists, please increment the version number"
        else
          logger.info(%(Loaded M3::Profile "#{profile_match.name}" ID=#{profile_match.id}))
          profile_match
        end
      end
    end

    private

    def self.construct_profile_contexts(profile:, logger: default_logger)
      profile_contexts_hash = profile.profile.dig('contexts')

      profile_contexts_hash.keys.each do |name|
        profile_context = profile.contexts.build(
          name:          name,
          display_label: profile_contexts_hash.dig(name, 'display_label')
        )
        logger.info(%(Constructed M3::ProfileContext "#{profile_context.name}"))

        construct_profile_classes(profile: profile, profile_context: profile_context)

        profile_context
      end
    end

    def self.construct_profile_classes(profile:, profile_context:, logger: default_logger)
      profile_classes_hash = profile.profile.dig('classes')

      profile_classes_hash.keys.each do |name|
        profile_class = profile.classes.build(
          name:          name,
          display_label: profile_classes_hash.dig(name, 'display_label'),
          schema_uri:    profile_classes_hash.dig(name, 'schema_uri')
        )
        logger.info(%(Constructed M3::ProfileClass "#{profile_class.name}"))

        profile_class.contexts << profile_context

        construct_profile_properties(profile: profile, profile_context: profile_context, profile_class: profile_class)

        profile_class
      end
    end

    def self.construct_profile_properties(profile:, profile_context:, profile_class:, logger: default_logger)
      properties_hash = profile.profile.dig('properties')

      properties_hash.keys.each do |name|
        property = profile.properties.build(
          name:                name,
          property_uri:        properties_hash.dig(name, 'property_uri'),
          cardinality_minimum: properties_hash.dig(name, 'cardinality', 'minimum'),
          cardinality_maximum: properties_hash.dig(name, 'cardinality', 'maximum'),
          ## TODO: Fails with the following error:
          #        ActiveRecord::RecordInvalid (Validation failed: Properties indexing _tesim is not a valid indexing term, Properties indexing _ssm is not a valid indexing term)
          #        (See: app/models/m3/profile_property.rb)
          #        Is :indexing supposed to be like ['_tesim', '_ssm'] or ['displayable', 'facetable']?
          indexing:            properties_hash.dig(name, 'indexing')
        )
        logger.info(%(Constructed M3::ProfileProperty "#{property.name}"))

        property.available_on_contexts << profile_context
        property.available_on_classes << profile_class

        property_text = property.texts.build(
          name:  name,
          # TODO: figure out how to replace 'default' with profile_context / profile_class
          value: properties_hash.dig(name, 'display_label', 'default')
          # TODO: need to implement these two attrs here?
          # textable_type:,
          # textable_id:
        )
        logger.info(%(Constructed M3::ProfileText "#{property_text.value}" for M3::ProfileProperty "#{property.name}"))

        property
      end
    end

    class ProfileVersionError < StandardError; end
  end
end
