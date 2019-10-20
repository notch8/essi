require 'active_support/core_ext/hash/keys'
module M3
  # @todo move custom error classes to a single location
  class NoM3ContextError < StandardError; end
  class NoM3AdminSetError < StandardError; end
  
  class DynamicSchemaService
<<<<<<< HEAD
    attr_accessor :dynamic_schema, :properties, :model, :m3_context
    
    # Retrieve the properties for the model / work type
    # This is a class method, meaning AdminSet is not available
    #   so we cannot get the contextual dynamic_schema
    #   instead we grab the default (contextless) dynamic_schema
    #   which will add all properties available for that class
    # @return [Hash] property => opts
    def self.model_properties(curation_concern_class_name:)
      sch = schema(curation_concern_class_name)['properties']
      model_props = {}
      model_props = sch.map do |prop_name, prop_value|
        { prop_name.to_sym => {
          predicate: predicate_for(prop_value['predicate']), 
          multiple: prop_value['singular'] == false }
        }
      end.inject(:merge) unless sch.blank?

      model_props[:dynamic_schema] = { 
        predicate: predicate_for('http://example.com/dynamic_schema'), 
        multiple: false
      }
      model_props
    end

    # Retrieve the latest default dynamic_schema
    def self.schema(curation_concern_class_name)
      @schema ||= M3::DynamicSchema.where(
        m3_class: curation_concern_class_name
        name: 'default'
      ).order('created_at').last.schema
    rescue
      @schema ||= {}
    end

    def self.predicate_for(predicate)
      ::RDF::URI.intern(predicate)
    end

    # @return [RDF::URI] the rdf_type URI
    def self.rdf_type(curation_concern_class_name:)
      rdf_type_for(
        schema(curation_concern_class_name)['type'],
        curation_concern_class_name
      )
    end

    def self.rdf_type_for(type, model)
      if type.blank?
        ::RDF::URI.intern("http://example.com/#{model}")
      else
        ::RDF::URI.intern(type)
      end
    end
=======
    attr_accessor :dynamic_schema, :m3_context, :m3_context_id, :model

    class << self
      # Retrieve the properties for the model / work type
      # This is a class method called by the model at class load
      #   meaning AdminSet is not available and we cannot get the
      #   contextual dynamic_schema
      # Instead we use the default (contextless) dynamic_schema
      #   which will add all properties available for that class
      # @return [Hash] property => opts
      def model_properties(work_class_name:)
        sch = schema(work_class_name: work_class_name)['properties']
        model_props = {}
        unless sch.blank?
          model_props = sch.map do |prop_name, prop_value|
            { prop_name.to_sym => {
              predicate: predicate_for(predicate_uri: prop_value['predicate']),
              multiple: prop_value['singular'] == false
            } }
          end.inject(:merge)
          model_props[:dynamic_schema] = dynamic_schema_property
        end
        model_props
      end
>>>>>>> WIP Refactoring and additional code, plus Image configured to use flexible_metadata

      # Retrieve the properties for the model / work type
      # This is a class method called by the model at class load
      #   meaning AdminSet is not available and we cannot get the
      #   contextual dynamic_schema
      # Instead we use the default (contextless) dynamic_schema
      #   which will add all properties available for that class
      # @return [Array] property#to_sym
      def default_properties(work_class_name:)
        props = schema(
          work_class_name: work_class_name
        )['properties'].symbolize_keys!.keys
        props << :dynamic_schema
        props
        rescue StandardError => e
          []
      end

      # Retrieve the latest default dynamic_schema
      def schema(work_class_name:)
        M3::DynamicSchema.where(
          m3_class: work_class_name,
          m3_context: M3::Context.where(name: 'default')
        ).order('created_at').last.schema
      rescue StandardError
        {}
      end

      # Retrieve the predicate for the given predicate uri
      # @param predicate_uri
      # @return [RDF::URI] predicate
      def predicate_for(predicate_uri:)
        ::RDF::URI.intern(predicate_uri)
      end

      # @return [RDF::URI] rdf_type
      def rdf_type(work_class_name:)
        rdf_type_for(
          type: schema(work_class_name: work_class_name)['type'],
          work_class_name: work_class_name
        )
      end

      # @param type - the rdf type value
      # @param model - the work type
      # @return [RDF::URI] rdf_type for given model
      def rdf_type_for(type:, work_class_name:)
        if type.blank?
          ::RDF::URI.intern("http://example.com/#{work_class_name}")
        else
          ::RDF::URI.intern(type)
        end
      end

      def dynamic_schema_property
        {
          predicate: predicate_for(predicate_uri: 'http://example.com/dynamic_schema'),
          multiple: false
        }
      end
    end

<<<<<<< HEAD
    # @return [Array] property keys
    def properties
      @properties ||= dynamic_schema.schema.deep_symbolize_keys![:properties].keys
=======
    def initialize(admin_set_id:, work_class_name:, dynamic_schema_id: nil)
      # @todo - remove - dev only
      AdminSet.class_eval do
        include M3::AdminSetBehavior
      end

      if admin_set_id.blank?
        raise M3::NoM3AdminSetError('The Admin Set ID is blank')
      end

      context_for(admin_set_id: admin_set_id)
      dynamic_schema_for(
        m3_context_id: m3_context_id,
        work_class_name: work_class_name,
        dynamic_schema_id: dynamic_schema_id
      )
      @model = work_class_name
    end

    # @return [Hash] property => array of indexing
    def indexing_properties
      indexers = {}
      properties.each_pair do |prop_name, prop_value|
        indexers[prop_name] = if prop_value[:indexing].blank?
          ["#{prop_name}#{default_indexing}"]
        else
          prop_value[:indexing].map do |indexing_key|
            "#{prop_name}#{index_as(indexing_key)}"
          end 
        end 
      end
      indexers
    end

    # @return [Array] property keys
    def property_keys
      @property_keys ||= properties.keys
>>>>>>> WIP Refactoring and additional code, plus Image configured to use flexible_metadata
    end

    # @return [Array] required properties
    def required_properties
      property_keys.map { |prop| required_for(prop) }.compact
    end

    # @todo renderers and other controls
    # @return [Array] hashes of property => label
    def view_properties
      property_keys.map do |prop|
        { prop => { label: property_locale(prop, 'label') } }
<<<<<<< HEAD
      end
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
=======
      end.inject(:merge)
>>>>>>> WIP Refactoring and additional code, plus Image configured to use flexible_metadata
    end

    # @param property - property name
    # @param locale_key - valid keys are: label, help_text
    # @return [String] the value for the given locale
    def property_locale(property, locale_key)
      unless locale_key.match('label' || 'help_text')
        return property.to_s.capitalize
      end

      label = I18n.t("m3.#{m3_context}.#{model}.#{locale_key}.#{property}")
      label = nil if label.include?('translation missing')
      label || send("#{locale_key}_for", property) || property.to_s.capitalize
    end

    private

<<<<<<< HEAD
    def dynamic_schema_for(m3_context_id:, curation_concern_class_name:)
      require 'active_support/core_ext/hash/keys'
      M3::DynamicSchema.where(m3_context: m3_context_id).select do |ds|
        ds.m3_class == curation_concern_class_name
      end.first
=======
    def context_for(admin_set_id:)
      cxt = AdminSet.find(admin_set_id).metadata_context
      if cxt.blank?
        raise M3::NoM3ContextError(
          "No Metadata Context for Admin Set #{admin_set_id}"
        )
      end
      @m3_context = cxt.name
      @m3_context_id = cxt.id
    end

    # Retrieve the given DynamicSchema for an existing work
    def dynamic_schema_for(m3_context_id:, work_class_name:, dynamic_schema_id: nil)
      if dynamic_schema_id.present?
        @dynamic_schema ||= M3::DynamicSchema.find(dynamic_schema_id)
      else
        @dynamic_schema ||= M3::DynamicSchema.where(m3_context: m3_context_id).select do |ds|
          ds.m3_class == work_class_name.to_s
        end.first
      end
    end

    def properties
      @properties ||= dynamic_schema.schema.deep_symbolize_keys![:properties]
>>>>>>> WIP Refactoring and additional code, plus Image configured to use flexible_metadata
    end

    def required_for(property)
      property if property_hash_for(property)[:required]
    end

<<<<<<< HEAD
    # Use stored_searchable as the default if the value is empty
    def indexing_for(property)
      property_hash_for(property)[:indexing] || ['stored_searchable']
    end

=======
>>>>>>> WIP Refactoring and additional code, plus Image configured to use flexible_metadata
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

    def property_hash_for(property)
      properties[property]
    end

    def default_indexing
      index_as('stored_searchable')
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
