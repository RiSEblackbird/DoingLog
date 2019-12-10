FactoryBot.define do
  factory :problem do
    title Faker::Base.regexify("[problemふぃ56]{100}")
    summary Faker::Base.regexify("[problemぃ57さあ]{1000}")
    solved true
  end
end
