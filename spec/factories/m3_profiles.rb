FactoryBot.define do

  factory :m3_profile, class: M3::Profile do
    name            { "Indiana University" }
    sequence(:profile_version) { |n| n }
    responsibility { 'http://iu.edu' }
    date_modified { '2019-09-23' }
    profile         { { "version": profile_version, "responsibility_statement":"Indiana University", "date_modified":"2019-09-9" } }
    classes { [FactoryBot.build(:m3_profile_class)] }
    contexts { [FactoryBot.build(:m3_profile_context)] }
    properties { [FactoryBot.build(:m3_profile_property)] }
    
  end

  factory :m3_profile_class, class: M3::ProfileClass do
    name            { "FlexibleWork" }
    display_label   { "Flexible Work" }
    contexts { [FactoryBot.build(:m3_profile_context)] }
    class_texts { [FactoryBot.build(:m3_profile_text_for_class)] }
  end

  factory :m3_profile_context, class: M3::ProfileContext do
    name            { "flexible_context" }
    display_label   { "Flexible Context" }
    context_texts { [FactoryBot.build(:m3_profile_text_for_context)] }
  end

  factory :m3_profile_property, class: M3::ProfileProperty do
    name            { "title" }
    available_on_classes { [ FactoryBot.build(:m3_profile_class) ] }
    available_on_contexts { [ FactoryBot.build(:m3_profile_context) ] }
    texts {[
      FactoryBot.build(:m3_profile_text),
      FactoryBot.build(:m3_profile_text_for_class),
      FactoryBot.build(:m3_profile_text_for_context)]}
  end

  factory :m3_profile_text, class: M3::ProfileText do
    name            { "display_label" }
    value            { "Title" }
  end

  factory :m3_profile_text_for_class, class: M3::ProfileText do
    name            { "display_label" }
    value            { "Title in Class" }
  end

  factory :m3_profile_text_for_context, class: M3::ProfileText do
    name            { "display_label" }
    value            { "Title in Context" }
  end
end
