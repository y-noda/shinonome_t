FactoryBot.define do
  factory :self_check do
    user { create(:user) }
    category { create(:category) }
    answer  { "[\"0\",\"1\",\"2\",\"3\",\"4\",\"5\"]" }
  end
end
