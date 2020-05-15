FactoryBot.define do
  factory :checksheet_answer do
    answer { "MyString" }
    user { FactoryBot.create(:user) }
    video { FactoryBot.create(:video) }
    correct_answer { false }
  end
end
