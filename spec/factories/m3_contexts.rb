FactoryBot.define do
  factory :m3_context, class: M3::Context do
    name       { "flexible_context" }
    m3_profile { FactoryBot.build(:m3_profile) }
  end
end
