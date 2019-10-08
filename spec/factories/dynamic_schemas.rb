FactoryBot.define do
  factory :dynamic_schema, class: M3::DynamicSchema do
    m3_class   { "FlexibleWork" }
    m3_context { FactoryBot.build(:m3_context) }
    m3_profile { FactoryBot.build(:m3_profile) }
    schema     { { "version": 1, "classes":"FlexibleWork", "contexts":"flexible_context" } }
  end
end
