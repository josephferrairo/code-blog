FactoryBot.define do
  factory :profile do
    user
    sequence(:biography) { |n| "biography #{n}" }
    sequence(:web_browser) { |n| "web_browser #{n}" }
    sequence(:text_editor) { |n| "text_editor #{n}" }
    sequence(:terminal) { |n| "terminal #{n}" }
  end
end
