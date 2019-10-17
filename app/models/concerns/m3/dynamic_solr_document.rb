module M3
  module DynamicSolrDocument
    extend ActiveSupport::Concern

    included do
      dynamic_schema_service.solr_attributes.each do |prop, value|
        attribute(prop, solr_class(value), solr_name(prop.to_s))
      end
    end

    def solr_class(solr_array)
      solr_array ? Solr::String : Solr::Array
    end
  end
end
