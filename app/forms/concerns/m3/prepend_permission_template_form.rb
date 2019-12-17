
module M3
  module PrependPermissionTemplateForm
    # override (from Hyrax 2.5.0) - new method to delegate to available_contexts
    # delegate :available_contexts, to: :metadata_context_class
    def available_contexts
      metadata_context_class.available_contexts
    end

    # override (from Hyrax 2.5.0) - new method to setup the metadata_context_class
    def metadata_context_class
      M3::Context
    end

    # override (from Hyrax 2.5.0) - new method to setup dropdown for metadata_context
    def metadata_context_options
      available_contexts.map { |c| [c.name, c.id] }
    end

    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/CyclomaticComplexity

    # override (from Hyrax 2.5.0) - extend method to add metadata_context
    # @return [Hash{Symbol => String, Boolean}]
    #   {
    #     :content_tab (for confirmation message),
    #     :updated (true/false),
    #     :error_code (for flash error lookup)
    #   }
    def update(attributes)
      @attributes = attributes
      return_info = { content_tab: tab_to_update }
      error_code = nil
      case return_info[:content_tab]
      when 'participants'
        update_participants_options
      when 'visibility'
        error_code = update_visibility_options
      when 'workflow'
        grant_workflow_roles
      when 'metadata_context'
        update_metadata_context
      end
      return_info[:error_code] = error_code if error_code
      return_info[:updated] = error_code ? false : true
      return_info
    end
    # rubocop:enable Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/MethodLength

    private

    # override (from Hyrax 2.5.0) - extend method to add metadata_context
    # @return [String]
    def tab_to_update
      return 'metadata_context' if attributes.key?(:metadata_context_id)
      super
    end

    # override (from Hyrax 2.5.0) - new method to add the admin_set_id to the M3::Context
    # @return [Nil]
    def update_metadata_context
      if attributes['metadata_context_id'].present?
        metadata_context = M3::Context.find(attributes['metadata_context_id'])
        metadata_context.admin_set_ids += [source_model.id]
        metadata_context.save
      end
      nil
    end
  end
end
