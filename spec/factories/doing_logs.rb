# frozen_string_literal: true

FactoryBot.define do
  factory :doing_log do
    title { Faker::Base.regexify('[doinglogふぃ56]{100}') }
    summary { Faker::Base.regexify('[doinglogぃ57おさ]{1000}') }
    association :user

    trait :invalid do
      title { nil }
    end
  end
end
