FactoryBot.define do
  factory :dynamic_schema do
    version { 1 }
    m3_class { "MyString" }
    m3_context { FactoryBot.build(:m3_context) }
    m3_profile { FactoryBot.build(:m3_profile) }
    schema { "" }
  end
end
