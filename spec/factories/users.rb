FactoryGirl.define do
  factory :user_without_profile, class: User do
    state      "profile_incomplete"
    email      { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    password   { Faker::Internet.password }

    factory :user, aliases: [:user_with_profile, :guest] do
      state            "completed_profile"
      date_of_birth    { Faker::Date.between(16.years.ago, 100.years.ago) }
      profession       { Faker::Company.catch_phrase }
      bio              { Faker::Lorem.paragraph }
      mobile_number    { Faker::PhoneNumber.phone_number }
      favorite_cuisine { Faker::Lorem.words(3) }
      greeting         { Faker::Lorem.sentence }

      factory :user_with_profile_pending_transition do
        state "completed_devise"
      end

      trait :host do
        after :create do |user|
          user.host = FactoryGirl.create(:host, name: user.decorate.full_name)
        end
      end
    end

    trait :facebook do
      after :create do |user|
        FactoryGirl.create(:facebook_identity, user: user)
      end
    end

    trait :twitter do
      after :create do |user|
        FactoryGirl.create(:twitter_identity, user: user)
      end
    end
  end
end
