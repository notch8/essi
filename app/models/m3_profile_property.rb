class M3ProfileProperty < ApplicationRecord
  belongs_to :m3_profile
  has_many :available_on_classes, class_name: 'M3ProfileClass'
  has_many :available_on_contexts, class_name: 'M3ProfileContext'
  has_many :texts, class_name: 'M3ProfileText', inverse_of: :property
  accepts_nested_attributes_for :texts
end
