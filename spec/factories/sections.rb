FactoryGirl.define do
  factory :section do
    title Faker::Hipster.sentence(3)
    description Faker::Hipster.sentence(20)
    rating
  end
end
