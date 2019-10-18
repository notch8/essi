FactoryBot.define do
  factory :dynamic_schema, class: M3::DynamicSchema do
    m3_class   { 'Image' }
    m3_context { FactoryBot.build(:m3_context_assigned) }
    m3_profile { FactoryBot.build(:m3_profile) }
    schema     do
      {
        'type' => 'http://example.com/classes/Image',
        'display_label' => 'Flexible Metadata Example',
        'properties' => [
          { 'title' =>
            {
              'predicate' => 'http://purl.org/dc/terms/title',
              'display_label' => 'Title in Context',
              'required' => true,
              'singular' => false,
              'indexing' => %w[
                stored_searchable
                facetable
              ]
            } }
        ]
      }
    end
  end
end
