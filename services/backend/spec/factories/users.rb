FactoryBot.define do
  factory :user do
    email                 { Faker::Internet.unique.email }
    password              { "MyP@ssw0rd$" }
    password_confirmation { "MyP@ssw0rd$" }

    trait(:confirmed) do
      confirmed_at { 1.week.ago }
    end
  end
end
