module M3
  class ProfileContext < ApplicationRecord
    self.table_name = 'm3_profile_contexts'
    has_many :context_texts, as: :textable, class_name: 'M3::ProfileText'
    accepts_nested_attributes_for :context_texts

    validates :name, :display_label, presence: true
  end
end
