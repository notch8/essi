class M3Context < ApplicationRecord
  belongs_to :m3_profile
  has_many :dynamic_schemas
  serialize :admin_set_ids, Array
end
