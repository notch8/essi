module M3
  class Profile < ApplicationRecord
    self.table_name = 'm3_profiles'
    # flexible metadata objects
    has_many :m3_contexts, class_name: 'M3::Context', foreign_key: 'm3_profile_id', dependent: :destroy
    has_many :dynamic_schemas, class_name: 'M3::DynamicSchema', foreign_key: 'm3_profile_id', dependent: :destroy
    # profile elements
    has_many :classes, class_name: 'M3::ProfileClass', foreign_key: 'm3_profile_id', dependent: :destroy
    has_many :contexts, class_name: 'M3::ProfileContext', foreign_key: 'm3_profile_id', dependent: :destroy
    has_many :properties, class_name: 'M3::ProfileProperty', foreign_key: 'm3_profile_id', dependent: :destroy
    accepts_nested_attributes_for :classes, :contexts, :properties
    # serlializations
    serialize :profile
    # validations
    validates :name, :profile, :profile_version, :responsibility, :date_modified, presence: true
    # callbacks
    after_save :check_profile_version
    after_create :create_m3_context

    def check_profile_version
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

    def create_m3_context
      # M3::Context.create(m3_profile_id: self.id)
    end
  end
end
