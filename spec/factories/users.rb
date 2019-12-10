FactoryBot.define do
  factory :user do
    username: Faker::Base.regexify("[userあ5]{30}")
    profile: Faker::Base.regexify("[userあ123gkj]{150}")
    email: Faker::Internet.email
    password: Faker::Lorem.characters(number: 20)
  end
end
