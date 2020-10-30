# frozen_string_literal: true

Bulkrax.setup do |config|
  # Add local parsers
  config.parsers += [
    { name: 'METS XML', class_name: 'Bulkrax::MetsXmlParser', partial: 'mets_xml_fields' },
  ]

  # Field to use during import to identify if the Work or Collection already exists.
  # Default is 'source'.
  # config.system_identifier_field = 'source'

  # WorkType to use as the default if none is specified in the import
  # Default is the first returned by Hyrax.config.curation_concerns
  # config.default_work_type = MyWork

  # Path to store pending imports
  # config.import_path = 'tmp/imports'

  # Path to store exports before download
  # config.export_path = 'tmp/exports'

  # Server name for oai request header
  # config.server_name = 'my_server@name.com'

  # Field_mapping for establishing the source_identifier
  # This value IS NOT used for OAI, so setting the OAI Entries here will have no effect
  # The mapping is supplied per Entry, provide the full class name as a string, eg. 'Bulkrax::CsvEntry'
  # Example:
  #   {
  #     'Bulkrax::RdfEntry'  => 'http://opaquenamespace.org/ns/identifier',
  #     'Bulkrax::CsvEntry'  => 'MyIdentifierField'
  #   }
  # The default value for CSV is 'source_identifier'
   config.source_identifier_field_mapping = {
     'Bulkrax::MetsXmlEntry'  => 'OBJID'
   }

  # Field_mapping for establishing a parent-child relationship (FROM parent TO child)
  # This can be a Collection to Work, or Work to Work relationship
  # This value IS NOT used for OAI, so setting the OAI Entries here will have no effect
  # The mapping is supplied per Entry, provide the full class name as a string, eg. 'Bulkrax::CsvEntry'
  # Example:
  #   {
  #     'Bulkrax::RdfEntry'  => 'http://opaquenamespace.org/ns/contents',
  #     'Bulkrax::CsvEntry'  => 'children'
  #   }
  # By default no parent-child relationships are added
  # config.parent_child_field_mapping = { }

  # Field_mapping for establishing a collection relationship (FROM work TO collection)
  # This value IS NOT used for OAI, so setting the OAI parser here will have no effect
  # The mapping is supplied per Entry, provide the full class name as a string, eg. 'Bulkrax::CsvEntry'
  # The default value for CSV is collection
  # Add/replace parsers, for example:
  # config.collection_field_mapping['Bulkrax::RdfEntry'] = 'http://opaquenamespace.org/ns/set'

  # Field mappings
  # Create a completely new set of mappings by replacing the whole set as follows
     config.field_mappings = {
       #"Bulkrax::OaiDcParser" => { **individual field mappings go here*** }
        "Bulkrax::CSVParser" => {
          "file" => { from: ["file"] },
          #"contributor" => { from: ["contributor"] },
          "creator" => { from: ["creator"] },
          #"date_created" => { from: ["date_created"] },
          #"description" => { from: ["description"] },
          #"identifier" => { from: ["identifier"] },
          #"language" => { from: ["language"], parsed: true },
          #"location" => { from: ["holding_location"], parsed: true },
          #"publisher" => { from: ["publisher"] },
          #"related_url" => { from: ["related_url"] },
          "rights_statement" => { from: ["rights_statement"] },
          "source" => { from: ["source"] },
          "source_identifier" => { from: ["source_identifier"] },
          #"subject" => { from: ["subject"], parsed: true },
          "title" => { from: ["title"] },
          #"resource_type" => { from: ["resource_type"], parsed: true },
          #"remote_files" => { from: ["thumbnail_url"], parsed: true }
        },
        "Bulkrax::MetsXmlParser" => {
          "source_identifier" => { from: ["identifier"] },
          "work_type" => 'PagedResource'
        }
     }

  # Add to, or change existing mappings as follows
  #   e.g. to exclude date
  #   config.field_mappings["Bulkrax::OaiDcParser"]["date"] = { from: ["date"], excluded: true  }

  # To duplicate a set of mappings from one parser to another
  #   config.field_mappings["Bulkrax::OaiOmekaParser"] = {}
  #   config.field_mappings["Bulkrax::OaiDcParser"].each {|key,value| config.field_mappings["Bulkrax::OaiOmekaParser"][key] = value }

  # Properties that should not be used in imports/exports. They are reserved for use by Hyrax.
  # config.reserved_properties += ['my_field']
end

