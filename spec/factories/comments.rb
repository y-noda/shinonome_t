FactoryBot.define do
  factory :comment do
    video { nil }
    user { nil }
    text { "MyString" }
  end
end
