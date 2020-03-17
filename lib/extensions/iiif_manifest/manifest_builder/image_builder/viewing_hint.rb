module Extensions
  module IIIFManifest
    module ManifestBuilder
      module ImageBuilder
        module ViewingHint
          def apply(canvas)
            canvas['viewingHint'] = canvas_viewing_hint(canvas) if canvas_viewing_hint(canvas).present?
            super
          end
        
          def canvas_viewing_hint(canvas)
            id = canvas['@id'].split('/').last
            FileSet.search_with_conditions({ id: id }, rows: 1)&.first['viewing_hint_tesim']&.first
          end
        end
      end
    end
  end
end
