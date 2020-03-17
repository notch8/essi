# Modify initialization to allow passing in an existing node_cache
# Needed for generating structure as nested OrderedList without id collision
module Extensions
  module ActiveFedora
    module Orders
      module OrderedList
        module InitializeNodeCache
          # @param [::RDF::Enumerable] graph Enumerable where ORE statements are
          #   stored.
          # @param [::RDF::URI] head_subject URI of head node in list.
          # @param [::RDF::URI] tail_subject URI of tail node in list.
          def initialize(graph,
                         head_subject,
                         tail_subject,
                         node_cache = ::ActiveFedora::Orders::OrderedList::NodeCache.new)
            @graph = if graph.respond_to?(:graph)
                       graph.graph.data
                     else
                       graph
                     end
            @head_subject = head_subject
            @tail_subject = tail_subject
            @node_cache = node_cache
            @changed = false
            tail
          end
        end
      end
    end
  end
end
