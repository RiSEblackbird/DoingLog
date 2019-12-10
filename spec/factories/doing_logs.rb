FactoryBot.define do
  factory :doing_log do
    title: Faker::Base.regexify("[doinglogふぃ56]{100}")
    summary: Faker::Base.regexify("[doinglogぃ57おさ]{1000}")
  end
end
