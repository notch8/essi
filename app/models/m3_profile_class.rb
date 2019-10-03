class M3ProfileClass < ApplicationRecord
  belongs_to :m3_profile
  has_many :contexts, class_name: 'M3ProfileContext'
  has_many :texts, as: :textable, class_name: 'M3ProfileText'
end
