FactoryGirl.define do

  factory :section do
    title Faker::Hipster.sentence(3)
    description Faker::Hipster.sentence(20)
    rating
  end

  factory :section_1, class: Section do
    title Faker::Hipster.sentence(2)
    description Faker::Hipster.sentence(25)
    rating
  end

  factory :section_2, class: Section do
    title Faker::Hipster.sentence(4)
    description Faker::Hipster.sentence(24)
    rating
  end
end
