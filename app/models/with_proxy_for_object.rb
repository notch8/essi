class WithProxyForObject < SimpleDelegator
  attr_reader :members
  def initialize(logical_order, members)
    @members = members
    super logical_order
  end

  def proxy_for_object
    @proxy_for_object ||= members.find { |x| x.id == proxy_for_id }
  end

  def label
    super || proxy_for_object.to_s
  end

  def unstructured_objects
    @unstructured_objects ||=
      begin
        unstructured_proxies = (members - all_nodes).map do |x|
          { "proxy": x.id }
        end
        node_class.new("nodes": unstructured_proxies)
      end
  end

  def each_node(&block)
    return enum_for(:each_node) unless block_given?
    nodes.each do |node|
      yield node.proxy_for_object if node.proxy_for_object
      node.send(:each_node, &block)
    end
  end

  def to_manifest_range
    ManifestRange.new(label: label, ranges: ranges, file_set_presenters: file_set_presenters)
  end

  def ranges
    @ranges ||= nodes.select { |n| n.proxy_for_id.nil? }.map(&:to_manifest_range)
  end

  def file_set_presenters
    @file_set_presenters ||= nodes.map(&:proxy_for_object).select(&:present?)
  end

  # Filters out any deleted nodes from UI presentation
  def nodes
    super.reject { |node| node.proxy_for_id.present? && node.proxy_for_object.nil? }
  end

  private

    def all_nodes
      @all_nodes ||= enum_for(:each_node).to_a
    end

    class Factory
      attr_reader :members
      def initialize(members)
        @members = members
      end

      def new(order_hash = {}, rdf_subject = nil, node_class = nil, top = true, node_cache = ActiveFedora::Orders::OrderedList::NodeCache.new)
        ::WithProxyForObject.new(
          LogicalOrder.new(order_hash, rdf_subject, node_class || self, top, node_cache),
          members
        )
      end
    end
end

class ManifestRange
  attr_reader :label, :ranges, :file_set_presenters
  def initialize(label:, ranges: [], file_set_presenters: [])
    @label = label
    @ranges = ranges
    @file_set_presenters = file_set_presenters
  end
end

