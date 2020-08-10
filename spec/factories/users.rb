# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    id { Faker::Lorem.characters(number: 4) }
    username { Faker::Base.regexify('[userあ5]{30}') }
    profile { Faker::Base.regexify('[userあ123gkj]{150}') }
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(number: 20) }
  end
end
