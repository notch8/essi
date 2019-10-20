
# Generated via
#  `rails generate hyrax:work Image`
module Hyrax
  class ImagePresenter < Hyrax::WorkShowPresenter
    # @todo - add to m3 generator
    class << self
      def delegated_properties
        M3::DynamicSchemaService.default_properties(
          work_class_name: 'Image'
        )
      end
    end
    # @todo - add to m3 generator
    delegate(*delegated_properties, to: :solr_document)
  end
end
