module M3
  class Profile < ApplicationRecord
    self.table_name = 'm3_profiles'
    # 
    before_destroy :check_for_works
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
    validates :name, :profile_version, :responsibility, presence: true
    validates :profile_version, uniqueness: true
    # callbacks
    before_create :add_date_modified
    #after_create :create_m3_context, :create_dynamic_schema
    after_create :set_profile

    def self.current_version?(profiles)
      newest_record = profiles.order("created_at").last
    end

    def available_classes
      #must be associated with a work
      Hyrax.config.curation_concerns.map(&:to_s)
    end

    # @todo, extend to full set in M3
    def available_text_names
      [
        ['Display Label','display_label']
      ]
    end

    def set_profile_version
      self.profile_version ? self.profile_version += 1 : self.profile_version = 1.0
    end

    private

    def add_date_modified
      self.date_modified ||= DateTime.now.strftime("%Y-%m-%d")
    end

    private

    def check_for_works
      self.m3_contexts.each do | m3_context |
        m3_context.admin_set_ids.each do | admin_set_id |
          if AdminSet.find(admin_set_id).members.count > 0
            self.errors.add(:base, 'A Profile with associated works cannot be destroyed.')
            throw :abort
          end
        end
      end
    end

    def create_m3_context
      #M3::Context.create
    end

    def create_dynamic_schema
      #DynamicSchema.create(m3_context_id: self.contexts.last.id, m3_profile_id: self.id)
    end

    def set_profile
      return unless self.profile.nil?

      hash = { "m3_version" => self.m3_version,
               "profile" => {
        "responsibility" => self.responsibility,
        "responsibility_statement" => self.responsibility_statement,
        "date_modified" => self.date_modified,
        "type" => self.profile_type,
        "version" => self.profile_version }
      }.merge!("classes" => class_hash, "contexts" => context_hash, "properties" => property_hash)

      self.update_attributes(profile: hash)
    end

    def class_hash
      class_collection = self.classes.map do |c|
        {
          c.name.to_s => { 
            "display_label" => c.display_label,
            "contexts" => self.contexts.pluck(:name)
           }
        }
      end
      Hash[*class_collection]
    end

    def context_hash
      context_collection = self.contexts.map do |c|
        {
          c.name.to_s => { 
            "display_label" => c.display_label
           }
        }
      end
      Hash[*context_collection]
    end

    def property_hash
      property_collection = self.properties.map do |p|
        {"title"=>
         {"display_label"=>
          {"default"=>p.name,
           "Image"=>"Title for Work Type",
           "flexible_context"=>"Title in Context"},
           "property_uri"=>p.property_uri,
           "available_on"=>{"classes"=>self.classes.pluck(:name), "contexts"=>self.contexts.pluck(:name)},
           "cardinality"=>{"minimum"=>p.cardinality_minimum},
           "index_documentation"=>
            "Title should be indexed as searchable and displayable.",
            "indexing"=>p.indexing
         }
        }
      end
      Hash[*property_collection]
    end

  end
end
