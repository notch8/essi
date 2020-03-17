# TODO Decide if we need this, or can use the stock Hyrax code, or the newer Hyrax code
module Extensions
  module Hyrax
    module WorkShowPresenter
      module ManifestMetadata
        # Copied from Hyrax gem
        # IIIF metadata for inclusion in the manifest
        #  Called by the `iiif_manifest` gem to add metadata
        #
        # @return [Array] array of metadata hashes
        def manifest_metadata
          metadata = []
          ::Hyrax.config.iiif_metadata_fields.each do |field|
            next unless methods.include?(field.to_sym)
      
            data = send(field)
            next if data.blank?
      
            metadata << {
              'label' => I18n.t("simple_form.labels.defaults.#{field}", default: field.to_s.humanize),
              'value' => Array.wrap(send(field))
            }
          end
          metadata
        end
      end
    end
  end
end
