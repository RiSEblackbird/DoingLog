# frozen_string_literal: true

FactoryBot.define do
  factory :try do
    title { Faker::Base.regexify('[tryふぃ56]{100}') }
    body { Faker::Base.regexify('[tryぃ57さあ]{1000}') }
    effective { true }
    association :user
    association :problem

    trait :invalid do
      title { nil }
    end
  end
end
