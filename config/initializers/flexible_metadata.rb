# frozen_string_literal: true

FlexibleMetadata.setup do |config|
  # Use a different base repository for the m3 json schema (eg. a fork)
  # Default:
  #
  # config.m3_schema_repository = 'https://raw.githubusercontent.com/samvera-labs/houndstooth'

  # Use a different version (eg. commit hash)
  # Default:
  #
  config.m3_schema_version_tag = '23ee57fb65521b0e31882e8b1fb690d67438bd9e'
end
