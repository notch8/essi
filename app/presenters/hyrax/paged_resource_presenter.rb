# Generated via
#  `rails generate hyrax:work PagedResource`
module Hyrax
  class PagedResourcePresenter < Hyrax::WorkShowPresenter
    include ESSI::PresentsStructure
    delegate :num_pages, :series, :viewing_direction, :viewing_hint,
             to: :solr_document

    def holding_location
      HoldingLocationAttributeRenderer.new(solr_document.holding_location).render_dl_row
    end

    def search_service
      return nil unless solr_document.ocr_searchable
      Rails.application.routes.url_helpers.solr_document_iiif_search_url(solr_document.id)
    end
  end
end
