
module M3
  module DynamicSolrDocument
    extend ActiveSupport::Concern

<<<<<<< HEAD
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
=======
    included do
      # override (from Hyrax 2.5.0) - setup the solr attributes dynamically
      # Gather all properties from the latest profile and setup the attributes
      # The SolrDocument is independent of the Model and Context, hence we use
      # profile directly.
      profile = M3::Profile.current_version
      profile.properties.each do |prop|
        attribute(
          prop.name,
          # if the property is singular, make it so
          prop.cardinality_maximum == 1 ? Hyrax::SolrDocument::Metadata::Solr::String : Hyrax::SolrDocument::Metadata::Solr::Array,
          solr_name(prop.name.to_s)
        )
      end unless profile.blank?
      attribute :dynamic_schema, Hyrax::SolrDocument::Metadata::Solr::String, solr_name(:dynamic_schema)
>>>>>>> WIP Refactoring and additional code, plus Image configured to use flexible_metadata
    end
  end
end
