module M3
  class Profile < ApplicationRecord
    self.table_name = 'm3_profiles'
    # flexible metadata objects
    has_many :m3_contexts, class_name: 'M3::Context', foreign_key: 'm3_profile_id', dependent: :destroy
    has_many :dynamic_schemas, foreign_key: 'm3_profile_id', dependent: :destroy
    # profile elements
    has_many :classes, class_name: 'M3::ProfileClass', foreign_key: 'm3_profile_id', dependent: :destroy
    has_many :contexts, class_name: 'M3::ProfileContext', foreign_key: 'm3_profile_id', dependent: :destroy
    has_many :properties, class_name: 'M3::ProfileProperty', foreign_key: 'm3_profile_id', dependent: :destroy
    accepts_nested_attributes_for :classes, :contexts, :properties
    # serlializations
    serialize :profile
    # validations
    validates :name, :responsibility, presence: true
    validates :profile_version, uniqueness: true
    # callbacks
    before_save :set_profile_version, on: :create

    after_save :set_profile_version
    #after_create :create_m3_context, :create_dynamic_schema

    def self.current_version?(profiles)
      newest_record = profiles.order("created_at").last
    end

    def available_classes
      #must be associated with a work
      Hyrax.config.curation_concerns.map(&:to_s)
    end

    private

    def create_dynamic_schema
      #DynamicSchema.create(m3_context_id: self.contexts.last.id, m3_profile_id: self.id)
    end

    def set_profile_version
      self.profile_version += 1

      # if we already have this version,
      #    compare the data,
      #    if it's the same,
      #      do nothing;
      #    if it's different
      #      return an error "This version already exists,
      #        please increment the version number"
      # else
      #  update version attribute by 1
      # end
    end
  end
end
