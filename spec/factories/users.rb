FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "#{n} Mike"}
    sequence(:last_name) { |n| "#{n} Smith"}
    sequence(:email) { |n| "#{n}@#{n}.com" }
    password "password"
  end
end
