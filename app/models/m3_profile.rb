class M3Profile < ApplicationRecord
  has_many :m3_contexts
  has_many :dynamic_schemas
end
