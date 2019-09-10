FactoryBot.define do
  factory :m3_profile do
    name            { "Indiana University" }
    profile_version { 1 }
    profile         { { "version": 0.1, "responsibility_statement":"Indiana University", "date_modified":"2019-09-9" } }
  end
end
