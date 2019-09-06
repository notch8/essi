FactoryBot.define do
  factory :dynamic_schema do
    version { 1 }
    m3class { "MyString" }
    m3context { nil }
    m3profile { nil }
    profile_version { 1 }
    schema { "" }
  end
end
