FactoryGirl.define do
  factory :usuario do
    nome { Faker::Name.name }
    email { Faker::Internet.email }
    password 'pass@1234'
    password_confirmation 'pass@1234'
    confirmed_at Date.today

    trait :admin do
      role :admin
    end

    trait :lojista do
      role :lojista
    end
  end
end
