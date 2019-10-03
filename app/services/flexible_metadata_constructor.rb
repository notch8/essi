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
      profile.m3_version               = data.dig(:m3_version)
      profile.profile_version          = data.dig(:profile, :version)
      profile.responsibility           = data.dig(:profile, :responsibility)
      profile.responsibility_statement = data.dig(:profile, :responsibility_statement)
      profile.date_modified            = data.dig(:profile, :date_modified)
      profile.profile_type             = data.dig(:profile, :type)
      profile.profile                  = data
      profile.save!
    end

    logger.info(%(Loaded M3Profile "#{profile.name}" ID=#{profile.id}))
    profile
  end

  private

    class ProfileVersionError < StandardError; end
end
