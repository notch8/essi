FactoryBot.define do
  factory :m3_context do
    name       { "flexible_context" }
    m3_profile { FactoryBot.build(:m3_profile) }
  end
end
