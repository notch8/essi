
require 'active_support/concern'

module M3
  module AdminSetBehavior
    extend ActiveSupport::Concern

    included do
      before_destroy :remove_from_m3_context
    end

    # override (from Hyrax 2.5.0) - new method (and after_destroy callback)
    #  to remove deleted admin_set from admin_set_ids
    def remove_from_m3_context
      m3_context = metadata_context
      unless m3_context.blank?
        m3_context.admin_set_ids = m3_context.admin_set_ids.reject { |aid| aid == id }
        m3_context.save
      end
    end

    # override (from Hyrax 2.5.0) - new method to add metadata_context
    # @api public
    #
    # @return [M3::Context]
    # @raise [ActiveRecord::RecordNotFound]
    def metadata_context
      M3::Context.find_metadata_context_for(
        admin_set_id: id
      )
    end
  end
end
