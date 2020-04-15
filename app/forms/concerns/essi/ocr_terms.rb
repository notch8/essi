module ESSI
  module OCRTerms
    extend ActiveSupport::Concern
    included do
      self.terms += [:ocr_state]
    end
  end
end
