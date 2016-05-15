FactoryGirl.define do
  factory :usuario do
    nome 'Faker::Name.name'
    email { "#{nome}@cablush.com".downcase }
    password 'pass@1234'
  end
end
