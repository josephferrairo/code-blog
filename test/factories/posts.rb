FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "title #{n}" }
    sequence(:body) { |n| "body #{n}" }
  end
end
