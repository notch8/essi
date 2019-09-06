class DynamicSchema < ApplicationRecord
  belongs_to :m3_context
  belongs_to :m3_profile

  serialize :schema, JSON

  delegate :profile_version, to: :m3_profile
end
