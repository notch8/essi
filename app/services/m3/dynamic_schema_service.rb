module M3
  # @todo move custom error classes to a single location
  class NoM3ContextError < StandardError; end

  class DynamicSchemaService
    attr_accessor :dynamic_schema, :properties, :model, :m3_context

    def initialize(admin_set_id:, curation_concern_class_name:)
      context = AdminSet.find(admin_set_id).metadata_context
      if context.blank?
        raise M3::NoM3ContextError(
          "No Metadata Context for Admin Set #{admin_set_id}"
        )
      end
      @m3_context = context.name
      @model = curation_concern_class_name
      @dynamic_schema = dynamic_schema_for(
        m3_context_id: context.id,
        curation_concern_class_name: curation_concern_class_name
      )
    end

    # @return [Array] property keys
    def properties
      @properties ||= dynamic_schema[:properties].map(&:keys).flatten
    end

    # @return [Hash] property => ActiveFedora::Attributes::NodeConfig
    def model_properties
      model_properties = {}
      properties.each do |prop|
        model_properties[prop] = ActiveFedora::Attributes::NodeConfig.new(
          prop,
          predicate_for(prop),
          opts_for(prop)
        )
      end
      model_properties
    end

    # @return [RDF::URI] the rdf_type URI
    def rdf_type
      rdf_type_for(dynamic_schema[:type])
    end

    # @return [Array] required properties
    def required_properties
      properties.map { |prop| required_for(prop) }
    end

    # @todo renderers and other controls
    # @return [Array] hashes of property => label
    def view_properties
      properties.map do |prop|
        { prop => { label: property_locale(prop, 'label') } }
      end
    end

    # @return [Array] hashes of property => singular true|false
    def solr_attributes
      properties.map { |prop| solr_attribute_for(prop) }
    end

    # @return [Hash] property => array of indexing
    def indexing_properties
      indexers = {}
      properties.each do |prop|
        indexers[prop] = indexing_for(prop).map do |indexing_key|
          "#{prop}#{index_as(indexing_key)}"
        end
      end
      indexers
    end

    # @param property - property name
    # @param locale_key - valid keys are: label, help_text
    # @return [String] the value for the given locale
    def property_locale(property, locale_key)
      return property.to_s.capitalize unless locale_key.match('label' || 'help_text')

      label = I18n.t("m3.#{m3_context}.#{model}.#{locale_key}.#{property}")
      label = nil if label.include?('translation missing')
      label || send("#{locale_key}_for", property) || property.to_s.capitalize
    end

    private

    def dynamic_schema_for(m3_context_id:, curation_concern_class_name:)
      require 'active_support/core_ext/hash/keys'
      M3::DynamicSchema.where(m3_context: m3_context_id).select do |ds|
        ds.m3_class == curation_concern_class_name
      end.first.schema.deep_symbolize_keys!
    end

    def rdf_type_for(type)
      if type.blank?
        ::RDF::URI.intern("http://example.com/#{model}")
      else
        ::RDF::URI.intern(type)
      end
    end

    def property_hash_for(property)
      dynamic_schema[:properties].map { |prop| prop.dig(property) }.compact.first
    end

    def predicate_for(property)
      ::RDF::URI.intern(property_hash_for(property)[:predicate])
    end

    # @todo extend to add type / class_name
    def opts_for(property)
      if property_hash_for(property)[:singular]
        { multiple: false }
      else
        { multiple: true }
      end
    end

    def required_for(property)
      property if property_hash_for(property)[:required]
    end

    # @todo - extend to add data_type for dates Solr::Date
    def solr_attribute_for(property)
      { property => property_hash_for(property)[:singular] }
    end

    # Use stored_searchable as the default if the value is empty
    def indexing_for(property)
      property_hash_for(property)[:indexing] || ['stored_searchable']
    end

    def locale_label_for(property)
      I18n.t("m3.#{m3_context}.#{model}.labels.#{property}") ||
        label_for(property) ||
        property.to_s.capitalize
    end

    def label_for(property)
      property_hash_for(property)[:display_label]
    end

    def help_text_for(property)
      property_hash_for(property)[:usage_guidelines]
    end

    # @param indexing_key from the following list:
    #   displayable: ['_ssm'],
    #   facetable: ['_sim'],
    #   searchable: ['_teim','_dtim','_iim'],
    #   sortable: ['_tei','_si','_dti','_ii',
    #   stored_searchable: ['_tesim','_dtsim','_isim'],
    #   stored_sortable: ['_ssi','_dtsi'],
    #   symbol: ['_ssim']
    #
    # default behaviour is to return the string/text variant
    # @todo comine with data type to determine indexing value
    def index_as(indexing_key)
      case indexing_key
      when 'stored_searchable'
        '_tesim'
      when 'facetable'
        '_ssm'
      when 'searchable'
        '_teim'
      when 'stored_sortable'
        '_ssi'
      when 'symbol'
        '_ssim'
      when 'displayable'
        '_ssm'
      else
        '_tesim'
      end
    end
  end
end
