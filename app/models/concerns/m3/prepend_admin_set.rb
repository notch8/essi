
module M3
  module PrependAdminSet


    # override (from Hyrax 2.5.0) - new method to add metadata_context
    # @api public
    #
    # @return [M3Context]
    # @raise [ActiveRecord::RecordNotFound]
    def metadata_context
      M3Context.find_metadata_context_for(admin_set_id: id)
    end
  end
end
