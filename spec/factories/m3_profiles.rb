FactoryBot.define do

  factory :m3_profile, class: M3Profile do
    name            { "Indiana University" }
    profile_version { 1 }
    profile         { { "version": 0.1, "responsibility_statement":"Indiana University", "date_modified":"2019-09-9" } }
  end

  factory :m3_profile_class, class: M3ProfileClass do
    name            { "FlexibleMetadata" }
    m3_profile { FactoryBot.build(:m3_profile) }
    contexts { [FactoryBot.build(:m3_profile_context)] }
  end

  factory :m3_profile_context, class: M3ProfileContext do
    name            { "flexible_metadata" }
    m3_profile { FactoryBot.build(:m3_profile) }
  end

  factory :m3_profile_property, class: M3ProfileProperty do
    name            { "title" }
    m3_profile { FactoryBot.build(:m3_profile) }
    available_on_classes { [ FactoryBot.build(:m3_profile_class) ] }
    available_on_contexts { [ FactoryBot.build(:m3_profile_context) ] }
  end

  factory :m3_profile_text, class: M3ProfileText do
    name            { "display_label" }
    value            { "Title" }
    property { FactoryBot.build(:m3_profile_property) }
  end
end
