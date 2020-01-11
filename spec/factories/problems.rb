# frozen_string_literal: true

FactoryBot.define do
  factory :problem do
    title { Faker::Base.regexify('[problemふぃ56]{100}') }
    summary { Faker::Base.regexify('[problemぃ57さあ]{1000}') }
    solved { true }
    association :user
    association :doing

    trait :invalid do
      title { nil }
    end
  end
end
