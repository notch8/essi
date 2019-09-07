FactoryBot.define do
  factory :m3_context do
    name { "MyString" }
    m3_profile { FactoryBot.build(:m3_profile) }
  end
end
