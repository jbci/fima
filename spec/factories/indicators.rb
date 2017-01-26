FactoryGirl.define do
  factory :indicator do
    title Faker::Hipster.sentence(3)
    description Faker::Hipster.sentence(30)
    section
  end
end
