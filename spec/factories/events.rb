FactoryGirl.define do
  factory :event do
    title            { Faker::Company.catch_phrase }
    location         { Faker::Address.city }
    description      { Faker::Lorem.paragraph }
    menu             { Faker::Lorem.paragraph }
    seats            { rand(5..20) }
    price_in_pennies { rand(500..5000) }
    currency         "GBP"
  end
end