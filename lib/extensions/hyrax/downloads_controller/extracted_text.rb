# Adds extracted text option to download files
# Example: http://example.edu/downloads/123456?file=extracted_text
module Extensions
  module Hyrax
    module DownloadsController
      module ExtractedText
        def load_file
          if params[:file] && params[:file] == 'extracted_text'
            association = dereference_file(:extracted_text)
            return association&.reader
          end
          super
        end
      end
    end
  end 
end
