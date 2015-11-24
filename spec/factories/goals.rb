FactoryGirl.define do
  factory :goal do
    title { Faker::Company.buzzword }
    description { Faker::Company.catch_phrase }
    user_id 1
    privacy "Public"
    status "Incomplete"

    factory :private_goal do
      privacy "Private"
      title 'I want to look good naked'
    end
  end
end
