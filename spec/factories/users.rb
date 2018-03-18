FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "#{n}@#{n}.com" }
    password "password"
  end
end
