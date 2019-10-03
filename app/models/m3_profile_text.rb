class M3ProfileText < ApplicationRecord
  belongs_to :property, class_name: 'M3ProfileProperty', inverse_of: :texts,
                        foreign_key: 'm3_profile_property_id'
  belongs_to :textable, polymorphic: true, required: false
end
