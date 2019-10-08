module M3
  class DynamicSchema < ApplicationRecord
    belongs_to :m3_context, class_name: 'M3::Context'
    belongs_to :m3_profile, class_name: 'M3::Profile'

    serialize :schema, JSON

    validates :m3_class, :schema, presence: true

    delegate :profile_version, to: :m3_profile
  end
end
