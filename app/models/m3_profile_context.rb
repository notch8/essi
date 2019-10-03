class M3ProfileContext < ApplicationRecord
  belongs_to :m3_profile
  has_many :context_texts, as: :textable, class_name: 'M3ProfileText'
end
