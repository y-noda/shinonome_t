FactoryBot.define do
  factory :user do
    sequence(:name) {|n|"general#{n}"}
    password { "password" }
    password_confirmation { "password" }
    administrator { false }
  end

  factory :administrator, class: User do
    sequence(:name) {|n|"admin#{n}"}
    password { "password" }
    password_confirmation { "password" }
    administrator { true }
  end
end
