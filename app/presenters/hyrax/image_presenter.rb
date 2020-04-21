# Generated via
#  `rails generate hyrax:work Image`
module Hyrax
  class ImagePresenter < Hyrax::WorkShowPresenter
    include ESSI::PresentsNumPages
    include ESSI::PresentsOCR
    include ESSI::PresentsStructure
    include FlexibleMetadata::DynamicPresenterBehavior
    self.model_class = ::Image
    delegate(*delegated_properties, to: :solr_document)
  end
end
