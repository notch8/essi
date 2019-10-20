# Generated via
#  `rails generate hyrax:work Image`
class Image < ActiveFedora::Base
  include ESSI::ImageBehavior
  include ::Hyrax::WorkBehavior

  M3::DynamicSchemaService.model_properties(curation_concern_class_name: self.to_s).each_pair do | prop, value |
    property prop, predicate: value[:predicate], multiple: value[:multiple]
  end
  type(M3::DynamicSchemaService.rdf_type(curation_concern_class_name: self.to_s))

  after_create :add_dynamic_schema

  def add_dynamic_schema
    self.dynamic_schema = dynamic_schema_service.dynamic_schema.id
  end

  def dynamic_schema_service
    @dynamic_schema_service ||= M3::DynamicSchemaService.new(
      admin_set_id: find_or_create_admin_set,
      curation_concern_class_name: self.class.to_s
    )  
  end

  # tricky because this is an instance method
  # one option is to use the generic properties for the class, because on the model this doesn't much matter
  # context only matters for lables etc.
  # matters for available on, but in base model terms, that's not so important
  # could do something at the save level to remove anything that isn't supported?
  # yes, that's it
  # we can only know the context on an instance
  # that's a fact
  def find_or_create_admin_set
    AdminSet.first.id
  end

  self.indexer = ImageIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }

 # Include extended metadata common to most Work Types
  # include ESSI::ExtendedMetadata

  # This model includes metadata properties specific to the Image Work Type
  # include ESSI::ImageMetadata

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata
end
