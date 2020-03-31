module ESSI
  module PresentsStructure

    # FIXME: delegate to solr_document?
    def logical_order
      @logical_order ||=
        begin
          JSON.parse(solr_document[Solrizer.solr_name("logical_order",
                                             :stored_searchable)].first)
        rescue StandardError
          {}
        end
    end

    def logical_order_object
      @logical_order_object ||=
          logical_order_factory.new(logical_order, nil, logical_order_factory)
    end

    def ranges
      Array.wrap(logical_order_object.to_manifest_range)
    end

    private
      def logical_order_factory
        @logical_order_factory ||=
          WithProxyForObject::Factory.new(member_presenters)
      end
  end
end
