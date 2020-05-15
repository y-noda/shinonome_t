FactoryBot.define do
  factory :questionnaire do
    category { FactoryBot.create(:category) }
    question { "MyString" }
  end
end
