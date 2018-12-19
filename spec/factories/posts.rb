FactoryBot.define do
  factory :post do
    title { FFaker::Lorem.word }
    description { FFaker::Lorem.paragraph }
    user
  end
end
