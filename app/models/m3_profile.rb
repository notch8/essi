class M3Profile < ApplicationRecord
  has_many :m3_contexts
  has_many :dynamic_schemas

  has_many :classes, class_name: 'M3ProfileClass', inverse_of: :m3_profile
  has_many :contexts, class_name: 'M3ProfileContext', inverse_of: :m3_profile
  has_many :properties, class_name: 'M3ProfileProperty', inverse_of: :m3_profile
  accepts_nested_attributes_for :classes, :contexts, :properties

  serialize :profile

  validates :name, :profile, presence: true

  after_save :check_profile_version
  after_create :create_m3_context

  def check_profile_version
    #if we already have this version, 
    #    compare the data,
    #    if it’s the same, 
    #      do nothing;
    #    if it’s different 
    #      return an error “This version already exists, 
    #        please increment the version number”
    #else
    #  update version attribute by 1
    #end
  end

  def create_m3_context
    #M3Context.create(m3_profile_id: self.id)
  end
end
