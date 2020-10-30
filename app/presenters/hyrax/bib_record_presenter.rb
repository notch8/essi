# Generated via
#  `rails generate hyrax:work BibRecord`
module Hyrax
  class BibRecordPresenter < Hyrax::WorkShowPresenter
    include ESSI::PresentsHoldingLocation
    include ESSI::PresentsNumPages
    include ESSI::PresentsOCR
    include ESSI::PresentsStructure
    include ESSI::PresentsRelatedUrl
    include ESSI::PresentsCampus
    delegate :series, to: :solr_document
    include AllinsonFlex::DynamicPresenterBehavior
    self.model_class = ::BibRecord
    delegate(*delegated_properties, to: :solr_document)
  end
end
