# Generated via
#  `rails generate hyrax:work PagedResource`
module Hyrax
  class PagedResourcePresenter < Hyrax::WorkShowPresenter
    include ESSI::PresentsOCR
    include ESSI::PresentsStructure
    delegate :series, :viewing_direction, :viewing_hint,
             to: :solr_document

    def holding_location
      HoldingLocationAttributeRenderer.new(solr_document.holding_location).render_dl_row
    end
    include AllinsonFlex::DynamicPresenterBehavior
    self.model_class = ::PagedResource
    delegate(*delegated_properties, to: :solr_document)
  end
end
