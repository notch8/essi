# Generated via
#  `rails generate hyrax:work Image`
class ImageIndexer < Hyrax::WorkIndexer
  class_attribute :model_class
  self.model_class = ::Image
  # This indexes the default metadata. You can remove it if you want to
  # provide your own metadata and indexing.
  include Hyrax::IndexesBasicMetadata
  include ESSI::ImageIndexerBehavior
  # @todo - add to m3 generator
  include M3::DynamicIndexerBehavior

  # Fetch remote labels for based_near. You can remove this if you don't want
  # this behavior
  include Hyrax::IndexesLinkedMetadata

  # Uncomment this block if you want to add custom indexing behavior:
  # def generate_solr_document
  #  super.tap do |solr_doc|
  #    solr_doc['my_custom_field_ssim'] = object.my_custom_property
  #  end
  # end
end
