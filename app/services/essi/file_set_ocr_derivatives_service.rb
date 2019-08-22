module ESSI
  class FileSetOCRDerivativesService < Hyrax::FileSetDerivativesService
    def create_derivatives(filename)
      return if ESSI.config.dig(:essi, :skip_derivatives)

      super
      create_hocr_derivatives(filename)
      create_word_boundaries
    end

    private

    def supported_mime_types
      file_set.class.image_mime_types
    end

    def create_hocr_derivatives(filename)
      return unless ESSI.config.dig(:essi, :create_hocr_files)
      OCRRunner.create(filename,
                       { source: :original_file,
                         outputs: [{ label: "#{file_set.id}-hocr.hocr",
                                     mime_type: 'text/html; charset=utf-8',
                                     format: 'hocr',
                                     container: 'extracted_text',
                                     language: file_set.ocr_language,
                                     url: uri }]})
    end

    def create_word_boundaries
      return unless ESSI.config.dig(:essi, :create_word_boundaries)
      file_set.reload
      return unless file_set.extracted_text.present?
      WordBoundariesRunner.create(file_set,
                       { source: :extracted_text,
                         outputs: [{ label: "#{file_set.id}-json.json",
                                     mime_type: 'application/json; charset=utf-8',
                                     format: 'json',
                                     container: 'transcript',
                                     url: uri }]})
    end
  end
end
