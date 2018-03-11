FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "#{n}@#{n}.comj" }
    password "password"
  end
end
