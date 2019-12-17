
# override (from Hyrax 2.5.0) - new module
module M3
  module DynamicMetadataBehavior
    extend ActiveSupport::Concern

    included do
      # Dynamically set up the metadata properties
      M3::DynamicSchemaService.model_properties(work_class_name: to_s).each_pair do |prop, value|
        property prop, predicate: value[:predicate], multiple: value[:multiple]
      end
      type(M3::DynamicSchemaService.rdf_type(work_class_name: to_s))
    end

    # Retrieve the dynamic schema
    def base_dynamic_schema(admin_set_id)
      self.dynamic_schema || dynamic_schema_service(admin_set_id).dynamic_schema.id
    end

    # Setup dynamic schema service
    def dynamic_schema_service(admin_set_id)
      @dynamic_schema_service ||= M3::DynamicSchemaService.new(
        admin_set_id: admin_set_id,
        work_class_name: self.class.to_s
      )
    end

  end
end
