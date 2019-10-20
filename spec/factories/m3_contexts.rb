FactoryBot.define do
  factory :m3_context, class: M3::Context do
    name       { "flexible_context" }
    m3_profile { FactoryBot.build(:m3_profile) }
    m3_profile_context { FactoryBot.build(:m3_profile_context) }
  end

  factory :m3_context_assigned, class: M3::Context do
    name       { "flexible_context" }
    m3_profile { FactoryBot.build(:m3_profile) }
    admin_set_ids { [AdminSet.find_or_create_default_admin_set_id] }
    m3_profile_context { FactoryBot.build(:m3_profile_context) }
  end

  factory :m3_context_default, class: M3::Context do
    name       { "default" }
    m3_profile { FactoryBot.build(:m3_profile) }
    m3_profile_context { FactoryBot.build(:m3_profile_context) }
  end
end
