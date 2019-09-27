class M3Profile < ApplicationRecord
  has_many :m3_contexts
  has_many :dynamic_schemas

  has_many :classes, class_name: 'M3ProfileClass', inverse_of: :m3_profile
  has_many :contexts, class_name: 'M3ProfileContext', inverse_of: :m3_profile
  has_many :properties, class_name: 'M3ProfileProperty', inverse_of: :m3_profile
  accepts_nested_attributes_for :classes, :contexts, :properties

  serialize :profile
end
