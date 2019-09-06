class M3Context < ApplicationRecord
  belongs_to :m3_profile
  has_many :dynamic_schemas
end
