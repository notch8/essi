class M3Profile < ApplicationRecord
  has_many :m3_contexts
  has_many :dynamic_schemas

  serialize :profile

  validates :name, :profile, presence: true
end
