FactoryGirl.define do
  factory :rating do
    title Faker::Hipster.sentence(3)
    description Faker::Hipster.sentence(20)
  end
end
