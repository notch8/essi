module M3
  class ProfileProperty < ApplicationRecord
    self.table_name = 'm3_profile_properties'

    has_many :available_properties, class_name: 'M3::ProfileAvailableProperty', foreign_key: 'm3_profile_property_id', dependent: :destroy
    has_many :available_on_classes, through: :available_properties, source: :available_on, source_type: 'M3::ProfileClass'
    has_many :available_on_contexts, through: :available_properties, source: :available_on, source_type: 'M3::ProfileContext'
    has_many :texts, class_name: 'M3::ProfileText', foreign_key: 'm3_profile_property_id', dependent: :destroy
    accepts_nested_attributes_for :texts

    serialize :indexing, Array
    validates :name, :indexing, presence: true
    validate :validate_indexing

    # array of valid values for indexing
    INDEXING = %w[displayable
                  facetable
                  searchable
                  sortable
                  stored_searchable
                  stored_sortable
                  symbol
                  fulltext_searchable].freeze

    private

    # validate indexing is included in INDEXING
    def validate_indexing
      indexing.each do |i|
        errors.add(:indexing, "#{i} is not a valid indexing term") unless INDEXING.include? i
      end
    end
  end
end
