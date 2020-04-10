
# override (from Hyrax 2.5.0) - new module
module M3
  module DynamicFormBehavior
    extend ActiveSupport::Concern

    included do
      class_attribute :base_terms
      self.base_terms = [:representative_id, :thumbnail_id, :rendering_ids, :files,
        :visibility_during_embargo, :embargo_release_date, :visibility_after_embargo,
        :visibility_during_lease, :lease_expiration_date, :visibility_after_lease,
        :visibility, :ordered_member_ids, :source, :in_works_ids,
        :member_of_collection_ids, :admin_set_id]

      # Set the terms at class level to the full default set - this will be used to determine permitted parameters
      self.terms = self.base_terms += M3::DynamicSchemaService.default_properties(
        work_class_name: model_class.to_s
      )
      self.required_fields = []
    end

    # @todo - add to m3 generator
    # override (from Hyrax 2.5.0) - override the initializer:
    #   set the terms and required terms to those from the contextual schema
    def initialize(model, current_ability, controller)
      self.class.terms = self.class.base_terms += controller.dynamic_schema_service.property_keys
      self.class.required_fields = controller.dynamic_schema_service.required_properties
      super(model, current_ability, controller)
    end
  end
end
