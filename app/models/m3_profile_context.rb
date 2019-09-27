class M3ProfileContext < ApplicationRecord
  belongs_to :m3_profile
  has_many :texts, as: :textable, class_name: 'M3ProfileText'
end
