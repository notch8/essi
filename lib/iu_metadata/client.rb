require 'faraday'
require 'nokogiri'
module IuMetadata
  class Client
    # rubocop:disable Metrics/AbcSize
    def self.retrieve(id, format)
      raise ArgumentError, 'Invalid id argument' unless bibdata? id
      if format == :mods
        url, src = retrieve_mods(id)
        data = strip_yaz(src)
        record = IuMetadata::ModsRecord.new(url, data)
      elsif format == :marc
        url, src = retrieve_marc(id)
        data = strip_yaz(src)
        record = IuMetadata::MarcRecord.new(url, data, source_metadata_identifier: id)
      else
        raise ArgumentError, 'Invalid format argument'
      end
      record
    end
    # rubocop:enable Metrics/AbcSize

    # Used for validating metadata identifiers in URLs
    def self.bibdata?(source_metadata_id)
      (source_metadata_id =~ /\A[a-zA-Z0-9\-\.]+\z/)&.zero? || false
    end

    BIBDATA_ERROR_MESSAGE = 'A valid metadata identifier may contain only ' \
                            'alphanumeric, underscore, hyphen, and period ' \
                            'characters.'.freeze

    # Extracts the data payload from a YAZ Proxy response
    private_class_method def self.strip_yaz(src)
      noko = Nokogiri::XML(src) do |config|
        config.strict.nonet.noblanks
      end
      data = noko.xpath('/zs:searchRetrieveResponse/zs:records/zs:record' \
      '/zs:recordData/child::node()').to_s
      data
    end

    private_class_method def self.retrieve_mods(id)
      conn = Faraday.new(url: 'http://dlib.indiana.edu:9000')
      response = conn.get do |req|
        req.url '/iucatextract'
        req.params['query'] = "cql.serverChoice=#{id}"
        req.params['recordSchema'] = 'mods'
        req.params['operation'] = 'searchRetrieve'
        req.params['version'] = '1.1'
        req.params['maximumRecords'] = '1'
      end
      [response.to_hash[:url].to_s, response.body]
    end

    private_class_method def self.retrieve_marc(id)
      conn = Faraday.new(url: 'http://dlib.indiana.edu:9000')
      response = conn.get do |req|
        req.url '/iucatextract'
        req.params['query'] = "cql.serverChoice=#{id}"
        req.params['recordSchema'] = 'marcxml'
        req.params['operation'] = 'searchRetrieve'
        req.params['version'] = '1.1'
        req.params['maximumRecords'] = '1'
      end
      [response.to_hash[:url].to_s, response.body]
    end
  end
end
