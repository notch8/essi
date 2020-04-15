module ESSI
  module PresentsOCR
    def search_service
      return nil unless solr_document.ocr_searchable
      Rails.application.routes.url_helpers.solr_document_iiif_search_url(solr_document.id)
    end
  end
end
