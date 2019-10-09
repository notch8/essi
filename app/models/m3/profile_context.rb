module M3
  class ProfileContext < ApplicationRecord
    self.table_name = 'm3_profile_contexts'
    has_many :available_properties, as: :available_on, class_name: 'M3::ProfileAvailableProperty'
		has_many :properties, through: :available_properties, source: :m3_profile_property
    has_many :context_texts, as: :textable, class_name: 'M3::ProfileText'
    accepts_nested_attributes_for :context_texts

    validates :name, :display_label, presence: true
  end
end
