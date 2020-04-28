# Generated via
#  `rails generate hyrax:work BibRecord`
module Hyrax
  class BibRecordPresenter < Hyrax::WorkShowPresenter
    include ESSI::PresentsNumPages
    include ESSI::PresentsOCR
    include ESSI::PresentsStructure
    delegate :series, to: :solr_document
    include FlexibleMetadata::DynamicPresenterBehavior
    self.model_class = ::BibRecord
    delegate(*delegated_properties, to: :solr_document)
  end
end
