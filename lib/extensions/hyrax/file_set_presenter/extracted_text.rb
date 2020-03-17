# Makes extracted text check available in file details.
module Extensions
  module Hyrax
    module FileSetPresenter
      module ExtractedText
        def extracted_text?
          ::FileSet.find(id).extracted_text.present?
        end
      
        def extracted_text_link
          "/downloads/#{id}?file=extracted_text"
        end
      end
    end
  end 
end
