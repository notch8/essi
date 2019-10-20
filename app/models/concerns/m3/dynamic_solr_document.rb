module M3
  module DynamicSolrDocument
    extend ActiveSupport::Concern

    # fix it moaning about Solr
    included do
      # Gather all properties from the latest profile
      # @todo - would this cause an error for older data?
      M3::Profile.current_version?(M3::Profile.all).properties.each do | prop |
        attribute(
          prop, 
          prop.cardinality_maximum == 1 ? Solr::String : Solr::Array, 
          solr_name(prop.to_s)
        )
      end
    end
  end
end
