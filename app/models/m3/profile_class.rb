module M3
  class ProfileClass < ApplicationRecord
    self.table_name = 'm3_profile_classes'
    has_many :contexts, class_name: 'M3::ProfileContext', foreign_key: 'm3_profile_class_id'
    has_many :class_texts, as: :textable, class_name: 'M3::ProfileText'
    accepts_nested_attributes_for :contexts, :class_texts

    validates :name, :display_label, presence: true
  end
end
