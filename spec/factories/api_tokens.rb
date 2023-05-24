FactoryBot.define do
  factory :api_token do
    user { nil }
    expires_at { "2023-05-24 12:38:32" }
    token { "MyText" }
  end
end
