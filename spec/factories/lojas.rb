FactoryGirl.define do
  factory :loja do
    nome 'Loja 1'
    descricao { Faker::Lorem.sentences.join(' ') }
    telefone '1234-4567'
    email 'loja1@lojas.com'
    association :responsavel, factory: :usuario, strategy: :build
  end
end
