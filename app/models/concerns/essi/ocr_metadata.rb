module ESSI
  module OCRMetadata
    extend ActiveSupport::Concern
    included do
      property :ocr_state, predicate: ::RDF::URI.new('http://dlib.indiana.edu/vocabulary/OCRState'), multiple: false do |index|
        index.as :stored_searchable
      end
    end
  end
end
